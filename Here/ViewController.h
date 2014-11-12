//
//  ViewController.h
//  
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "ScoopsModel.h"
#import "searchViewController.h"


@interface ViewController : UIViewController

@property NSString* name;
@property NSString* longitude;
@property NSString* latitude;
@property NSString* address;
@property NSString* contact;


//@property(nonatomic,retain) CLLocationManager *locationManager;
//@property (strong, nonatomic) IBOutlet MKMapView *currentMap;

//- (NSString *)deviceLocation;



@end
