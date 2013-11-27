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
    CLLocationDegrees longitude = [[collegeData objectAtIndex:1] doubleValue];
    CLLocationDegrees latitude = [[collegeData objectAtIndex:2] doubleValue];
    int newid = [[collegeData objectAtIndex:3] integerValue];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
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
    
    
    NSString *collegeURL = [NSString stringWithFormat:@"https://www.cribspot.com/Map/APIGetBasicData/0/%d?token=jg836djHjTk95Pxk69J6X4",newid];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:collegeURL]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSArray * collegeInfo=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&jsonParsingError];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-img/dots/dot_available.png"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *availimage = [UIImage imageWithData:data];

    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-img/dots/dot_leased.png"]];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    UIImage *leasedimage = [UIImage imageWithData:data2];
    
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat: @"https://s3-us-west-2.amazonaws.com/cribspot-img/dots/dot_unknown.png"]];
    NSData *data3 = [NSData dataWithContentsOfURL:url3];
    UIImage *unknownimage = [UIImage imageWithData:data3];
    
    
    
    //add university ids
    int count =0;
    for (NSDictionary *test1 in collegeInfo) {
        NSDictionary *Marker = [test1 objectForKey:@"Marker"];
        NSDictionary *Listing = [test1 objectForKey:@"Listing"];
        NSDictionary *Sublet = [test1 objectForKey:@"Sublet"];
        NSNumber *testlong =[Marker objectForKey:@"longitude"];
        NSNumber *testlat =[Marker objectForKey:@"latitude"];
        id available = [Listing objectForKey:@"available"];

        
        
        
        GMSMarker *markerTest =[[GMSMarker alloc] init];
        markerTest.position = CLLocationCoordinate2DMake((CLLocationDegrees)[testlat doubleValue], (CLLocationDegrees)[testlong doubleValue]);
        markerTest.icon= availimage;
        if (available==[NSNull null]) {
            markerTest.icon= unknownimage;
        }
        else if ([available boolValue]) {
            markerTest.icon= availimage;
        }
        else{
            markerTest.icon = leasedimage;
        }
        

        
        markerTest.map =mapView_;
        
        if (count++>200) {
            break;
        }
        
    }
    
    
    
    
    mapView_.delegate=self;
    
    
    
    
    
    
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
