//
//  ViewController.m
//  cribspot
//
//  Created by Patrick Wilson on 10/17/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "ViewController.h"
#import "CollegeCell.h"
#import "MapView.h"

@interface ViewController (){
    NSDictionary *CollegeInfo;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *collegeURL = @"http://www.cribspot.com/Universities/GetUniversities?token=jg836djHjTk95Pxk69J6X4";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:collegeURL]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSArray * colleges=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&jsonParsingError];
    
    NSMutableArray *idarray =[[NSMutableArray alloc] init];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSMutableArray *imagenames=[[NSMutableArray alloc] init];
    NSMutableArray *latitudes=[[NSMutableArray alloc] init];
    NSMutableArray *longitudes=[[NSMutableArray alloc] init];
    
    //add university ids
    
    for (NSDictionary *test in colleges) {
        NSDictionary *boom = [test objectForKey:@"University"];
        NSString *name = [boom objectForKey:@"full_name"];
        NSString *imagename = [boom objectForKey:@"logo_path"];
        NSNumber *latitude = [boom objectForKey:@"latitude"];
        NSNumber *longitude = [boom objectForKey:@"longitude"];
        NSNumber *ids = [boom objectForKey:@"id"];
        
        
        NSString *newpath = [imagename substringWithRange:NSMakeRange(1, [imagename length]-1)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-%@", newpath]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        [idarray addObject:ids];
        [names addObject:name];
        [imagenames addObject:img];
        [latitudes addObject:latitude];
        [longitudes addObject:longitude];
    }
    
    
    
    
    
    CollegeInfo = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:names,imagenames,longitudes,latitudes, idarray,nil] forKeys:[NSArray arrayWithObjects:@"names",@"pictures",@"long",@"lat",@"ids",nil]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[CollegeInfo objectForKey:@"names"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"CollegeCell";
    
    CollegeCell *cell = (CollegeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CollegeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.label.text =  [[CollegeInfo objectForKey:@"names"] objectAtIndex:indexPath.row];
    
    
    
    
    
    
    
    
    [cell.image setImage:[[CollegeInfo objectForKey:@"pictures"] objectAtIndex:indexPath.row]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    MapView *lvc = [storyboard instantiateViewControllerWithIdentifier:@"mapBaby"];
    
    
    
    lvc.collegeData = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:[[CollegeInfo objectForKey:@"names"] objectAtIndex:indexPath.row]],[[CollegeInfo objectForKey:@"long"] objectAtIndex:indexPath.row],[[CollegeInfo objectForKey:@"lat"] objectAtIndex:indexPath.row],[[CollegeInfo objectForKey:@"ids"] objectAtIndex:indexPath.row],nil];
    [self.navigationController pushViewController:lvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (IBAction)login:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    UIView *view = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:view animated:YES];
    
    
}
@end
