//
//  houseDetail.m
//  cribspot
//
//  Created by Patrick Wilson on 10/25/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "houseDetail.h"

@interface houseDetail ()

@end

@implementation houseDetail
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
    [self.image setImage:[UIImage imageNamed:[houseData objectAtIndex:1]]];

    self.descLabel.text = [houseData objectAtIndex:2];
    self.navigationItem.title = [houseData objectAtIndex:0];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
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
@end
