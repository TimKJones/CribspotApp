//
//  MapView.h
//  cribspot
//
//  Created by Patrick Wilson on 10/24/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapView : UIViewController <GMSMapViewDelegate>

@property(nonatomic) NSMutableArray *collegeData;
@property (weak, nonatomic) IBOutlet UIToolbar *testToolbar;
- (IBAction)favoriteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@end
