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
    CollegeInfo = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"University of Michigan",@"Michigan State University",@"Indiana University",@"University of Wisconsin", nil],[NSArray arrayWithObjects:@"UM.png",@"MSU.png",@"IU.png",@"UW.png", nil], nil] forKeys:[NSArray arrayWithObjects:@"names",@"pictures",nil]];
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
    
    cell.label.text =  [NSString stringWithFormat:[[CollegeInfo objectForKey:@"names"] objectAtIndex:indexPath.row]];
    [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:[[CollegeInfo objectForKey:@"pictures"] objectAtIndex:indexPath.row]]]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    MapView *lvc = [storyboard instantiateViewControllerWithIdentifier:@"mapBaby"];
    [self.navigationController pushViewController:lvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
