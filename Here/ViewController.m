//
//  ViewController.m
//  Google Maps API
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"VC: %@, %@, %@", self.name, self.longitude, self.latitude);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue] zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.icon = [GMSMarker markerImageWithColor:[UIColor brownColor]];
    marker.position = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    marker.title = self.name;
    marker.snippet = [NSString stringWithFormat:@"%@: %@", self.contact, self.address];

    marker.map = mapView_;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
