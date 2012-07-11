//
//  HomePageTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageTableView.h"
#import "DataCollection.h"
#import "SchoolDetails.h"
#import "LoginView.h"
#import "ProfileEditView.h"
#import "SchoolEditView.h"

@interface HomePageTableView ()
@end

@implementation HomePageTableView
@synthesize userName = _userName;
@synthesize homePageTableView;
@synthesize schoolList = _schoolList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.schoolList = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
    
    if (self.schoolList == nil)
    {
        return;
    }
    else
    {
        if ([self.schoolList count] > 0)
        {
            NSLog(@"School List:");
            for (SchoolDetails *item in self.schoolList)
            {
                NSLog(@"School Found: %@ - %@",item.schoolName, item.schoolDetails);
            }
        }
    }
    
    [super viewWillAppear:(BOOL)animated];
//    
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setHomePageTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.schoolList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"homePageCell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SchoolDetails *selectedObject = [self.schoolList objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedObject schoolName];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.getData  = @"Logout";
        LoginView.userName = self.userName;
	}
    else if ([segue.identifier isEqualToString:@"segueEditProfile"])
    {
        ProfileEditView *ProfileEditView = [segue destinationViewController];
        
        ProfileEditView.getData  = @"Edit";
        ProfileEditView.userName = self.userName;
    }
    else if ([segue.identifier isEqualToString:@"AddEditSchoolSegue"])
    {
        SchoolEditView *SchoolEditView = [segue destinationViewController];
        
        SchoolEditView.getData  = @"Edit";
        SchoolEditView.userName = self.userName;
    }
    else if ([segue.identifier isEqualToString:@"CreateSchoolSegue"])
    {
        SchoolEditView *SchoolEditView = [segue destinationViewController];
        
        SchoolEditView.userName = self.userName;
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataCollection *data = [[DataCollection alloc] init];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        NSManagedObject *schoolToDelete = [self.schoolList objectAtIndex:indexPath.row];
        [data deleteSchool:schoolToDelete];
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    SchoolDetails *movedSchool = [self.schoolList objectAtIndex:fromIndexPath.row];
    
}
*/
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
