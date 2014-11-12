//
//  searchViewController.m
//  Here
//
//  Created by Marcus Finney on 10/14/14.
//
//

#import "searchViewController.h"

@interface searchViewController ()
@property (strong, nonatomic) IBOutlet UILabel *recentDestinationsCountLabel;
@property (strong, nonatomic) IBOutlet UITableView *recentDestinationsTableView;
@property (strong, nonatomic) IBOutlet UITextField *identityTextField;
@property (strong, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (strong, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (nonatomic) NSInteger indexPathRow;

@end

@implementation searchViewController


-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([PFUser currentUser])
    {
        [self fillArraysByQuery];
    }
}

//fill local destination arrays upon entering page
- (void)fillArraysByQuery
{
    [[[ScoopsModel sharedModel] destinationLatitudesArray] removeAllObjects];
    [[[ScoopsModel sharedModel] destinationLongitudesArray] removeAllObjects];
    [[[ScoopsModel sharedModel] destinationContactsArray] removeAllObjects];
    [[[ScoopsModel sharedModel] destinationAddressesArray] removeAllObjects];
    [[[ScoopsModel sharedModel] destinationNamesArray] removeAllObjects];
    
    NSLog(@"Here: %@", [[PFUser currentUser] objectId]);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    [query whereKey:@"userID" equalTo:[[PFUser currentUser] objectId]];
    [query whereKey:@"contact" equalTo:self.contact];

    [query findObjectsInBackgroundWithBlock:^(NSArray *destination, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Do something with the found objects
            for (PFObject *destiny in destination) {
                [[ScoopsModel sharedModel] populateDestinationsData:destiny[@"name"]:destiny[@"longitude"]:destiny[@"latitude"] :destiny[@"address"] :destiny[@"contact"]
                 ];
                
                [self.ids addObject:destiny[@"objectID"]];
                
                NSLog(@"Populated %@: long-%@, lat-%@.", destiny[@"name"],destiny[@"longitude"],destiny[@"latitude"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [self.recentDestinationsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.names = [[ScoopsModel sharedModel] destinationNamesArray];
    self.latitudes = [[ScoopsModel sharedModel] destinationLatitudesArray];
    self.longitudes = [[ScoopsModel sharedModel] destinationLongitudesArray];
    self.contacts = [[ScoopsModel sharedModel] destinationContactsArray];
    self.addresses = [[ScoopsModel sharedModel] destinationAddressesArray];

    [self.recentDestinationsTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.names = [[ScoopsModel sharedModel] destinationNamesArray];
    self.latitudes = [[ScoopsModel sharedModel] destinationLatitudesArray];
    self.longitudes = [[ScoopsModel sharedModel] destinationLongitudesArray];
    self.contacts = [[ScoopsModel sharedModel] destinationContactsArray];
    self.addresses = [[ScoopsModel sharedModel] destinationAddressesArray];

    [self.recentDestinationsTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([PFUser currentUser])
    {
        //user logged in
        [self.recentDestinationsTableView reloadData];
    }
}

//add new destination
- (IBAction)addNewDestination:(id)sender {
    
    self.name = self.identityTextField.text;
    self.longitude = self.longitudeTextField.text;
    self.latitude = self.latitudeTextField.text;
    self.address = self.addressTextField.text;
    
    [[ScoopsModel sharedModel] storeCurrentDestination:self.name :self.longitude :self.latitude :self.address :self.contact];
    
    self.recentDestinationsCountLabel.text = [NSString stringWithFormat:@"Recent Entries (%d):", self.names.count];
    
    [self.recentDestinationsTableView reloadData];
}

//number of cells
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.names.count;
}

//select old destination
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPathRow = indexPath.row;
    NSLog(@"indexPath: %ld",(long)self.indexPathRow);
    
    self.name = [self.names objectAtIndex:(self.names.count - self.indexPathRow)-1];
    self.longitude = [self.longitudes objectAtIndex:(self.longitudes.count - self.indexPathRow)-1];
    self.latitude = [self.latitudes objectAtIndex:(self.latitudes.count - self.indexPathRow)-1];
    self.contact = [self.contacts objectAtIndex:(self.contacts.count - self.indexPathRow)-1];
    self.address = [self.addresses objectAtIndex:(self.addresses.count - self.indexPathRow)-1];
}

//fill in cells with info
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"destinationCell";
    
    UITableViewCell *cell = [self.recentDestinationsTableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [self.names objectAtIndex:(self.names.count - indexPath.row - 1)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: (%@, %@)", [self.addresses objectAtIndex:(self.longitudes.count - indexPath.row - 1)], [self.latitudes objectAtIndex:(self.latitudes.count - indexPath.row - 1)], [self.longitudes objectAtIndex:(self.longitudes.count - indexPath.row - 1)]];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *dest = segue.destinationViewController;
    
    dest.name = self.name;
    dest.longitude = self.longitude;
    dest.latitude = self.latitude;
    dest.contact = self.contact;
    dest.address = self.address;

    
    [self.recentDestinationsTableView reloadData];
}

@end
