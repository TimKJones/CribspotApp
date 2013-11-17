//
//  MapView.m
//  cribspot
//
//  Created by Patrick Wilson on 10/24/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "MapView.h"
#import "SearchView.h"
#import "houseDetail.h"
#import "CollegeCell.h"
#include <GoogleMaps/GoogleMaps.h>

@interface MapView ()
@end

@implementation MapView
{
    NSDictionary *houseData;
    UIView *test;
}
@synthesize collegeData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)searchClick:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    SearchView *sv = [storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self.navigationController pushViewController:sv animated:YES];
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    if (test.hidden==TRUE) {
        //test.hidden=FALSE;
    }
    else{
        test.hidden=TRUE;
    }
    
        return false;
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    houseDetail *det = [storyboard instantiateViewControllerWithIdentifier:@"houseDetail"];
    NSUInteger tag = marker.zIndex -1;
    
    det.houseData = [[NSMutableArray alloc] initWithObjects:
                     [[houseData objectForKey:@"address"] objectAtIndex:tag],
                     [[houseData objectForKey:@"pictures"] objectAtIndex:tag],
                     [[houseData objectForKey:@"desc"] objectAtIndex:tag],
                     nil];
    [self.navigationController pushViewController:det animated:YES];
}


- (void)viewDidLoad
{
    CLLocationDegrees longitude = [[collegeData objectAtIndex:2] doubleValue];
    CLLocationDegrees latitude = [[collegeData objectAtIndex:3] doubleValue];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:longitude
                                                            longitude:latitude
                                                                 zoom:13];
    GMSMapView *mapView_ = [GMSMapView mapWithFrame:[[UIScreen mainScreen] applicationFrame] camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;
    UIEdgeInsets mapInsets = UIEdgeInsetsMake(45.0, 10.0, 49.0, 0.0);
    mapView_.padding = mapInsets;
    
    
    test = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, self.view.frame.size.width, 78)];
    test.backgroundColor = [UIColor whiteColor];
    
    test.hidden =YES;
    
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(42.271873, -83.750764);
    marker1.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker1.title = @"203 Koch Ave";
    marker1.snippet = @"J Keller Properties";
    marker1.map =mapView_;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(42.285218, -83.739853);
    marker2.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker2.title = @"727 E. Kingsley";
    marker2.snippet = @"J Keller Properties";
    marker2.map =mapView_;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(42.280876, -83.728920);
    marker3.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker3.title = @"Markley Hall";
    marker3.snippet = @"Michigan Housing";
    marker3.map =mapView_;
    
    GMSMarker *marker4 = [[GMSMarker alloc] init];
    marker4.position = CLLocationCoordinate2DMake(42.295809, -83.717945);
    marker4.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker4.title = @"Northwood 3";
    marker4.snippet = @"Michigan Housing";
    marker4.map =mapView_;
    
    
    marker1.zIndex=1;
    marker3.zIndex=2;
    marker2.zIndex=3;
    marker4.zIndex=4;
    
    
    
    
    mapView_.delegate=self;
    houseData = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"203 Koch Ave",@"Mary Markley Hall",@"727 E. Kingsley",@"Northwood 3", nil],[NSArray arrayWithObjects:@"203.png",@"mark.png",@"727.png",@"north.png", nil],[NSArray arrayWithObjects:@"This 6 Bedroom Beauty is a steal for $9250/month",@"\"Real Wolverines live in Mary Markley Hall\" - Mary Sue", @"Don't let the size of the place fool you.  This beige-walled biznatch makes those tenants go OYY YOY YOY!",@"If you like having friends, FORGET ABOUT IT. Literally the most antisocial place on Earth. Where friendships go to die. $26,000 per month.",nil], nil] forKeys:[NSArray arrayWithObjects:@"address",@"pictures",@"desc",nil]];
    
    
    
    
    
    UIBarButtonItem *CSLogo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick:)
                                                    ];
    self.navigationItem.rightBarButtonItem=CSLogo;
    
    self.navigationItem.title = @"Cribspot";
    
    
   
    

    
    [self.view addSubview:mapView_];
    [self.view bringSubviewToFront:self.testToolbar];
    [self.view addSubview:test];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoriteButton:(id)sender {
    if (self.favoriteButton.tintColor == [UIColor redColor]) {
        self.favoriteButton.tintColor = nil;
        
    }
    else{
        self.favoriteButton.tintColor = [UIColor redColor];
        
    }
}
- (IBAction)loginButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    UIViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:login animated:YES];
}
@end
