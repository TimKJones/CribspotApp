//
//  houseDetail.h
//  cribspot
//
//  Created by Patrick Wilson on 10/25/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseDetail : UIViewController

@property(nonatomic) NSMutableArray *houseData;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)favorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;

@end


