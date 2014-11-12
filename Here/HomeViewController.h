//
//  HomeViewController.h
//  Scoops
//
//  Created by Marcus Finney on 10/16/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "ScoopsModel.h"
#import "ViewController.h"


@interface HomeViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property NSString* contact;
@property NSMutableArray* ids;
@property NSMutableArray* contacts;

- (void)fillContactsByQuery;


@end
