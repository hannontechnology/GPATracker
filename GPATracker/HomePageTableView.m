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
#import "ProfileEditTableView.h"
#import "SchoolEditTableView.h"
#import "HomePageTableCell1.h"
#import "SemesterTableView.h"
#import "User+Create.h"

@interface HomePageTableView ()
@end

@implementation HomePageTableView
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize userInfo = _userInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

- (void)setupFetchedResultsController
{
    NSString *entityName = @"SchoolDetails";
    NSLog(@"Seeting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"schoolEndYear" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat: @"user = %@", self.userInfo];
    NSLog(@"filtering data based on user = %@", self.userInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];

    [super viewWillAppear:(BOOL)animated];

    [self setupFetchedResultsController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"homePageCell1";
    HomePageTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[HomePageTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //SchoolDetails *selectedObject = [self.schoolList objectAtIndex:indexPath.row];
    SchoolDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.cellLabel1.text = [selectedObject schoolName];
    cell.cellLabel2.text = [selectedObject schoolDetails];
    cell.cellLabel3.text = [NSString stringWithFormat:@"%@ - %@", [selectedObject schoolStartYear], [selectedObject schoolEndYear]];
    cell.cellLabelGPA.text = [NSString stringWithFormat:@"%@", [selectedObject schoolActualGPA].stringValue];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.setLogoutStatus = @"Logout";
	}
    else if ([segue.identifier isEqualToString:@"segueEditProfile"])
    {
        ProfileEditTableView *ProfileEditTableView = [segue destinationViewController];
        
        ProfileEditTableView.setEditStatus = @"Edit";
        ProfileEditTableView.userInfo = self.userInfo;
        ProfileEditTableView.dataCollection = self.dataCollection;
        ProfileEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueEditSchool"])
    {
        SchoolDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SchoolEditTableView *SchoolEditTableView = [segue destinationViewController];
        
        SchoolEditTableView.setEditStatus = @"Edit";
        SchoolEditTableView.userInfo = self.userInfo;
        SchoolEditTableView.dataCollection = self.dataCollection;
        SchoolEditTableView.managedObjectContext = self.managedObjectContext;
        SchoolEditTableView.schoolInfo = selectedObject;
    }
    else if ([segue.identifier isEqualToString:@"segueCreateSchool"])
    {
        UINavigationController *navCon = [segue destinationViewController];
        SchoolEditTableView *SchoolEditTableView = [navCon.viewControllers objectAtIndex:0];
        
        SchoolEditTableView.userInfo = self.userInfo;
        SchoolEditTableView.dataCollection = self.dataCollection;
        SchoolEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueSemesterList"])
    {
        SchoolDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SemesterTableView *SemesterTableView = [segue destinationViewController];
        
        SemesterTableView.schoolInfo = selectedObject;
        SemesterTableView.dataCollection = self.dataCollection;
        SemesterTableView.managedObjectContext = self.managedObjectContext;
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *schoolToDelete = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        [self.managedObjectContext deleteObject:schoolToDelete];
        [self.managedObjectContext save:nil];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer.state != UIGestureRecognizerStateBegan )
        return; // discard everything else

    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    self.selectedIndexPath = [self.tableView indexPathForRowAtPoint:p];
    if (self.selectedIndexPath == nil)
        NSLog(@"long press on table view but not on a row");
    else
        NSLog(@"long press on table view at row %d", self.selectedIndexPath.row);

    alert = [[UIAlertView alloc] initWithTitle:@"Edit/Delete" message:@"Please edit or delete item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", @"Delete", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self performSegueWithIdentifier: @"segueEditSchool" sender: self];
    }
    else if (buttonIndex == 2)
    {
        NSManagedObject *schoolToDelete = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        [self.managedObjectContext deleteObject:schoolToDelete];
        [self.managedObjectContext save:nil];
        //[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier: @"segueSemesterList" sender: self];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
