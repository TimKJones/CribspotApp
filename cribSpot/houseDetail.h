//
//  houseDetail.h
//  cribspot
//
//  Created by Patrick Wilson on 10/25/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseDetail : UIViewController

@property(nonatomic) NSNumber *houseData;
@property (weak, nonatomic) IBOutlet UIImageView *image;


- (IBAction)favorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *rent;
@property (weak, nonatomic) IBOutlet UILabel *bedbath;
@property (weak, nonatomic) IBOutlet UIButton *listingbutton;
- (IBAction)listingclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *email_button;
- (IBAction)emailclick:(id)sender;

@end


