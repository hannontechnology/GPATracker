//
//  SemesterTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterTableView.h"
#import "DataCollection.h"
#import "SemesterDetails.h"
#import "LoginView.h"
#import "SemesterEditTableView.h"
#import "HomePageTableView.h"
#import "SemesterDetails+Create.h"

@interface SemesterTableView ()
@end

@implementation SemesterTableView
@synthesize schoolInfo = _schoolInfo;
@synthesize semesterList = _semesterList;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

- (void)setupFetchedResultsController
{
    // Create fetch request for the entity
        // Edit the entity name as appropriate
    NSString *entityName = @"SemesterDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorYear = [[NSSortDescriptor alloc] initWithKey:@"semesterYear" ascending:YES];
    NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"semesterName" ascending:YES selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorYear, sortDescriptorName, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"schoolDetails = %@", self.schoolInfo];
    NSLog(@"filtering data based on schoolDetails = %@", self.schoolInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
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
    return [self.semesterList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataCollection *data = [[DataCollection alloc] init];
    
    static NSString *CellIdentifier = @"semesterListCell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SemesterDetails *selectedObject = [self.semesterList objectAtIndex:indexPath.row];
    
    // TODO: create class semesterListCell2 and include custom labels for display to cell
    cell.textLabel.text = [selectedObject semesterName];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DataCollection *data = [[DataCollection alloc] init];
    
    NSLog(@"prepareForSegue Event of SemesterTableView");
    if ([segue.identifier isEqualToString:@"segueAddSemester"])
    {
        // Use this code if going to a navigation controller before accessing destination screen
        UINavigationController *navCon = [segue destinationViewController];
        SemesterEditTableView *SemesterEditTableView = [navCon.viewControllers objectAtIndex:0];
        
//        SemesterEditTableView.schoolName = self.schoolName;
    }
    else if ([segue.identifier isEqualToString:@"segueEditSemester"])
    {
        SemesterDetails *selectedObject = [self.semesterList objectAtIndex:self.selectedIndexPath.row];
        SemesterEditTableView *SemesterEditTableView = [segue destinationViewController];
        
//        SemesterEditTableView.schoolName = self.schoolName;
        SemesterEditTableView.semesterName = [selectedObject semesterName];
        SemesterEditTableView.setEditStatus = @"Edit";
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
        // Delete the row from the data source
        NSManagedObject *semesterToDelete = [self.semesterList objectAtIndex:indexPath.row];
        [data deleteSchool:semesterToDelete];
        
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
}
*/

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;

    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    self.selectedIndexPath = [self.tableView indexPathForRowAtPoint:p];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Edit/Delete" message:@"Please edit or delete item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", @"Delete", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self performSegueWithIdentifier:@"segueEditSemester" sender:self];
    }
    else if (buttonIndex == 2)
    {
        DataCollection *data = [[DataCollection alloc] init];
//        self.semesterList = [data retrieveSemesterList:(NSString *)self.schoolName userName:(NSString *)self.userName];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
