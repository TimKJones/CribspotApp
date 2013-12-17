//
//  SearchView.m
//  cribspot
//
//  Created by Patrick Wilson on 10/26/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "SearchView.h"
#import "houseTable.h"

@interface SearchView ()

@end

@implementation SearchView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Enter Search Criteria";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 12;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d Beds",row+1];
    if (row==0) {
        title = [@"" stringByAppendingFormat:@"%d Bed",row+1];
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 150;
    
    return sectionWidth;
}

- (IBAction)search_pressed:(id)sender {
    NSInteger row;
    
    row = [self.spinner selectedRowInComponent:0]+1;
    NSLog(@"%d",row);
    
    //searched_houses
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    houseTable *view = [storyboard instantiateViewControllerWithIdentifier:@"searched_houses"];
    NSNumber *newid = [NSNumber numberWithInt:4986];
    NSString *collegeURL = [NSString stringWithFormat:@"https://www.cribspot.com/Map/APIGetBasicData/0/%@?token=jg836djHjTk95Pxk69J6X4",newid];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:collegeURL]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSArray * collegeInfo=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&jsonParsingError];
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    NSMutableArray *photos =[[NSMutableArray alloc] init];
    NSMutableArray *descriptions=[[NSMutableArray alloc] init];
    int count =0;
    for (NSDictionary *boom in collegeInfo) {
        
        
            
            NSDictionary *Marker = [boom objectForKey:@"Marker"];
            int markerid = [[Marker objectForKey:@"marker_id"] integerValue];
    
            NSDictionary *Rental = [boom objectForKey:@"Rental"];
            NSString *address = [Marker objectForKey:@"street_address"];
            NSNumber *rent = [Rental objectForKey:@"rent"];
            NSString *beds = [Rental objectForKey:@"beds"];
        
        
        if (![beds isEqual:[NSNull null]]&&[beds isEqual:[NSString stringWithFormat:@"%d",row]]) {
            count ++;
            //NSLog(address);
            
            NSString *markerURL = [NSString stringWithFormat:@"https://www.cribspot.com/Listings/APIGetListingsByMarkerId/%d?token=jg836djHjTk95Pxk69J6X4",markerid];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:markerURL]];
            NSError *error;
            NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            NSError *jsonParsingError = nil;
            if (!error) {
                NSArray * markerInfo=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&jsonParsingError];
                for (NSDictionary *boom in markerInfo){
                    NSDictionary *Marker = [boom objectForKey:@"Marker"];
                    NSDictionary *Rental = [boom objectForKey:@"Rental"];
                    NSString *baths = [Rental objectForKey:@"baths"];
                    NSArray *Image = [boom objectForKey:@"Image"];
                    
                    NSString* bbstring = [NSString stringWithFormat:@"%@ Beds and %@ Baths",beds,baths];
                    
                    [descriptions addObject:bbstring];
                    [addresses addObject:address];
                    
                    if ([Image count]>=1) {
                        NSDictionary *imgdic = [Image objectAtIndex:0];
                        NSString *imgpath = [imgdic objectForKey:@"image_path"];
                        NSString *newpath = [imgpath substringWithRange:NSMakeRange(13, [imgpath length]-13)];
                        
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-img/listings/sml_%@",newpath]];
                        NSData *data = [NSData dataWithContentsOfURL:url];
                        UIImage *img = [UIImage imageWithData:data];
                        [photos addObject:img];
                        
                    }else{
                        [photos addObject:[UIImage imageNamed:@"nopic.jpg"]];
                        
                    }

                    
                    
                    break;
                    
                }
            }

            
            
            
            
            
            
            
            
            
            
            
            
        }
    
        if (count>10) {
            
            break;
        }
    
        
    }
    
    view.houseData = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:addresses,photos,descriptions, nil] forKeys:[NSArray arrayWithObjects:@"address",@"pictures",@"desc",nil]];
    
    
    
    [self.navigationController pushViewController:view animated:YES];
    
    
    
    
    
    
    
   
}
@end
