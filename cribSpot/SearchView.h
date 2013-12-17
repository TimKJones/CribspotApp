//
//  SearchView.h
//  cribspot
//
//  Created by Patrick Wilson on 10/26/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *searchbutton;
- (IBAction)search_pressed:(id)sender;

@end
