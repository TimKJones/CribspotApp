//
//  houseTable.m
//  cribspot
//
//  Created by Patrick Wilson on 10/25/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "houseTable.h"
#include "CollegeCell.h"
#include "houseDetail.h"

@interface houseTable ()

@end

@implementation houseTable
@synthesize houseData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Search Results";
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[houseData objectForKey:@"address"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CollegeCell";
    
    CollegeCell *cell = (CollegeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CollegeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.addressLabel.text =  [NSString stringWithFormat:[[houseData objectForKey:@"address"] objectAtIndex:indexPath.row]];
    cell.descLabel.text = [NSString stringWithFormat:[[houseData objectForKey:@"desc"] objectAtIndex:indexPath.row]];
    [cell.image setImage:[[houseData objectForKey:@"pictures"] objectAtIndex:indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    houseDetail *lvc = [storyboard instantiateViewControllerWithIdentifier:@"houseDetail"];
    lvc.houseData = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:[[houseData objectForKey:@"address"] objectAtIndex:indexPath.row]],[NSString stringWithFormat:[[houseData objectForKey:@"pictures"] objectAtIndex:indexPath.row]],[[houseData objectForKey:@"desc"] objectAtIndex:indexPath.row],nil];
    [self.navigationController pushViewController:lvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
