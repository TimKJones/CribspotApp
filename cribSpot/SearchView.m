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
    view.houseData = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"203 Koch Ave",@"Mary Markley Hall",@"727 E. Kingsley",@"Northwood 3", nil],[NSArray arrayWithObjects:@"203.png",@"mark.png",@"727.png",@"north.png", nil],[NSArray arrayWithObjects:@"This 6 Bedroom Beauty is a steal for $9250/month",@"\"Real Wolverines live in Mary Markley Hall\" - Mary Sue", @"Don't let the size of the place fool you.  This beige-walled biznatch makes those tenants go OYY YOY YOY!",@"If you like having friends, FORGET ABOUT IT. Literally the most antisocial place on Earth. Where friendships go to die. $26,000 per month.",nil], nil] forKeys:[NSArray arrayWithObjects:@"address",@"pictures",@"desc",nil]];
    [self.navigationController pushViewController:view animated:YES];
    
   
}
@end
