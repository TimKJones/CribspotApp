//
//  houseDetail.m
//  cribspot
//
//  Created by Patrick Wilson on 10/25/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "houseDetail.h"
#import <MessageUI/MessageUI.h>


@interface houseDetail ()

@end

@implementation houseDetail{
    NSString *website;
    NSString *email;
    NSString *phone;
    NSString *address;
}
@synthesize houseData;
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
    /*
    [self.image setImage:[UIImage imageNamed:[houseData objectAtIndex:1]]];

    self.descLabel.text = [houseData objectAtIndex:2];
    self.navigationItem.title = [houseData objectAtIndex:0];
     */
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    NSString *markerURL = [NSString stringWithFormat:@"https://www.cribspot.com/Listings/APIGetListingsByMarkerId/%d?token=jg836djHjTk95Pxk69J6X4",[houseData integerValue]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:markerURL]];
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSError *jsonParsingError = nil;
    if (!error) {
        NSArray * markerInfo=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&jsonParsingError];
        for (NSDictionary *boom in markerInfo){
            NSDictionary *Marker = [boom objectForKey:@"Marker"];
            NSDictionary *Rental = [boom objectForKey:@"Rental"];
            
            address = [Marker objectForKey:@"street_address"];
            NSString *rent = [Rental objectForKey:@"rent"];
            NSString *baths = [Rental objectForKey:@"baths"];
            NSString *beds = [Rental objectForKey:@"beds"];
            website = [Rental objectForKey:@"website"];
            email = [Rental objectForKey:@"contact_email"];
            phone = [Rental objectForKey:@"contact_phone"];
            
            NSArray *Image = [boom objectForKey:@"Image"];
            
            
            
            
            
            NSString *bbstring = [NSString stringWithFormat:@"%@ Beds and %@ Baths",beds,baths];
            
            
            NSString *rentstring = [NSString stringWithFormat:@"$%@/m",rent];
            
            self.navigationItem.title = address;
            if (rent==[NSNull null]) {
                rent =@"No rent info available";
            }
            else{
                rent = [NSString stringWithFormat:@"$%@/m",rent];
            }
            
            self.rent.text = rent;
            
            if ([Image count]>=1) {
                NSDictionary *imgdic = [Image objectAtIndex:0];
                NSString *imgpath = [imgdic objectForKey:@"image_path"];
                NSString *newpath = [imgpath substringWithRange:NSMakeRange(13, [imgpath length]-13)];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-img/listings/lrg_%@",newpath]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                [self.image setImage:img];
                
                
                
            }else{
                [self.image setImage:[UIImage imageNamed:@"nopic.jpg"]];
            }
            
        
            if (beds==[NSNull null]) {
                self.bedbath.text =@"No bed/bath info available";
            }
            else{
                self.bedbath.text = [NSString stringWithFormat:@"%@ Beds and %@ Baths",beds,baths];
            }
            
          
        
            
            break;
            
        }
    }

    
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];


    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favorite:(id)sender {
    if (self.favoriteButton.tintColor == [UIColor redColor]) {
        self.favoriteButton.tintColor = nil;

    }
    else{
        self.favoriteButton.tintColor = [UIColor redColor];

    }
    }
- (IBAction)listingclick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}
- (IBAction)emailclick:(id)sender {
    //GET EMAIL SENT HERE
    if (![email isEqual:[NSNull null]]) {
        MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
        [mailcontroller setMailComposeDelegate:self];
        NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil];
        [mailcontroller setToRecipients:emailArray];
        [mailcontroller setSubject:[NSString stringWithFormat:@"%@ Inquiry",address]];
        [self presentViewController:mailcontroller animated:YES completion:nil];
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (IBAction)callclick:(id)sender {
    
    if (![phone isEqual:[NSNull null]]) {
        NSString *phoneNumber = [@"tel://" stringByAppendingString:phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}
@end