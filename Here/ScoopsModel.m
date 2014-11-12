//
//  ScoopsModel.m
//  Here
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import "ScoopsModel.h"

static ScoopsModel *sharedModel;


@implementation ScoopsModel

+(id)sharedModel
{
    if (!sharedModel)
    {
        sharedModel = [[ScoopsModel alloc] init];
    }
    return sharedModel;
}

-(id)init
{
    self.destinationNamesArray = [[NSMutableArray alloc] init];
    self.destinationLongitudesArray = [[NSMutableArray alloc] init];
    self.destinationLatitudesArray = [[NSMutableArray alloc] init];
    self.destinationContactsArray = [[NSMutableArray alloc] init];
    self.destinationAddressesArray = [[NSMutableArray alloc] init];
    self.userContactsArray = [[NSMutableArray alloc] init];

    return self;
}

-(void)storeCurrentDestination:(NSString*)name :(NSString*)longitude :(NSString*)latitude :(NSString*)address :(NSString*)contact
{
    //make parse record
    PFObject *account = [PFObject objectWithClassName:@"Account"];
    account[@"userID"] = [[PFUser currentUser] objectId];
    account[@"name"] = name;
    account[@"longitude"] = longitude;
    account[@"latitude"] = latitude;
    account[@"contact"] = contact;
    account[@"address"] = address;

    [account saveInBackground];
    
    [self populateDestinationsData:name :longitude :latitude :address :contact];
}

-(void)populateDestinationsData:(NSString*)name :(NSString*)longitude :(NSString*)latitude :(NSString*)address :(NSString*)contact
{
    //add items to cached destinations
    [self.destinationNamesArray addObject:name];
    [self.destinationLongitudesArray addObject:longitude];
    [self.destinationLatitudesArray addObject:latitude];
    [self.destinationContactsArray addObject:contact];
    [self.destinationAddressesArray addObject:address];
    
    NSLog(@"ADDED2: %@, %d",name, self.userContactsArray.count);

}

-(void)newContact:(NSString*)name
{
    PFObject *contact = [PFObject objectWithClassName:@"Contact"];
    contact[@"userID"] = [[PFUser currentUser] objectId];
    contact[@"name"] = name;
    
    [contact saveInBackground];
    
    [self populateContactsData:name];
}

-(void)populateContactsData:(NSString*)name
{
    //contacts to a user
    [self.userContactsArray addObject:name];
    
    NSLog(@"ADDED: %@, %d",name, self.userContactsArray.count);
}



@end
