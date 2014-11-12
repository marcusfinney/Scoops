//
//  ScoopsModel.h
//  Here
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ScoopsModel : NSObject


@property (strong, nonatomic) NSMutableArray *destinationNamesArray;        //holds all destinationIDs
@property (strong, nonatomic) NSMutableArray *destinationLongitudesArray;   //holds long for a given destination
@property (strong, nonatomic) NSMutableArray *destinationLatitudesArray;    //holds lat for a given destination
@property (strong, nonatomic) NSMutableArray *destinationContactsArray;     //holds contact for a given destination
@property (strong, nonatomic) NSMutableArray *destinationAddressesArray;     //holds contact for a given destination
@property (strong, nonatomic) NSMutableArray *userContactsArray;            //holds all of a users contacts

+(id)sharedModel;
-(id)init;
-(void)storeCurrentDestination:(NSString*)name :(NSString*)longitude :(NSString*)latitude :(NSString*)address :(NSString*)contact;
-(void)populateDestinationsData:(NSString*)name :(NSString*)longitude :(NSString*)latitude :(NSString*)address :(NSString*)contact;
-(void)newContact:(NSString*)name;
-(void)populateContactsData:(NSString*)name;



@end
