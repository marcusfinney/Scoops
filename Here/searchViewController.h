//
//  searchViewController.h
//  Here
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "ScoopsModel.h"
#import "ViewController.h"

@interface searchViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField *textField;
-(IBAction)textFieldReturn:(id)sender;

@property NSString* name;
@property NSString* longitude;
@property NSString* latitude;
@property NSString* contact;
@property NSString* address;


@property NSMutableArray* ids;
@property NSMutableArray* names;
@property NSMutableArray* longitudes;
@property NSMutableArray* latitudes;
@property NSMutableArray* contacts;
@property NSMutableArray* addresses;


- (void)fillArraysByQuery;



@end
