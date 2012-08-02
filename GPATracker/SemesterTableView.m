//
//  SemesterTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterTableView.h"
#import "DataCollection.h"
//#import "LoginView.h"
#import "HomePageTableView.h"
#import "CourseTableView.h"
#import "SemesterEditTableView.h"
#import "SemesterDetails+Create.h"
#import "CourseDetails.h"
#import "HomePageTableCell1.h"
#import "SchoolDetails+Create.h"

@interface SemesterTableView ()
@end

@implementation SemesterTableView
@synthesize schoolInfo = _schoolInfo;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize schoolNameText = _schoolNameText;
@synthesize schoolDescText = _schoolDescText;
@synthesize schoolYearsText = _schoolYearsText;
@synthesize schoolCGPAText = _schoolCGPAText;

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

-(IBAction)back
{
    [self performSegueWithIdentifier: @"segueSemesterList2SchoolList" sender: self];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    [super viewWillAppear:(BOOL)animated];
    
    self.schoolNameText.text = self.schoolInfo.schoolName;
    self.schoolDescText.text = self.schoolInfo.schoolDetails;
    self.schoolYearsText.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];
    self.schoolCGPAText.text = [NSString stringWithFormat:@"%@", [self.schoolInfo schoolActualGPA].stringValue];

    [self setupFetchedResultsController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"BackButton-h32.png"];
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"School List" forState:UIControlStateNormal];
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setSchoolNameText:nil];
    [self setSchoolDescText:nil];
    [self setSchoolYearsText:nil];
    [self setSchoolCGPAText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"semesterListCell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    SemesterDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [selectedObject semesterName];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueAddSemester"])
    {
        // Use this code if going to a navigation controller before accessing destination screen
        UINavigationController *navCon = [segue destinationViewController];
        SemesterEditTableView *SemesterEditTableView = [navCon.viewControllers objectAtIndex:0];
        
        SemesterEditTableView.schoolDetails = self.schoolInfo;
        SemesterEditTableView.dataCollection = self.dataCollection;
        SemesterEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueEditSemester"])
    {
        SemesterDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SemesterEditTableView *SemesterEditTableView = [segue destinationViewController];
        
        SemesterEditTableView.semesterDetails = selectedObject;
        SemesterEditTableView.schoolDetails = self.schoolInfo;
        SemesterEditTableView.dataCollection = self.dataCollection;
        SemesterEditTableView.managedObjectContext = self.managedObjectContext;
        SemesterEditTableView.setEditStatus = @"Edit";
    }
    else if ([segue.identifier isEqualToString:@"segueCourseList"])
    {
        SemesterDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        CourseTableView *CourseTableView = [segue destinationViewController];
        
        CourseTableView.semesterInfo = selectedObject;
        CourseTableView.dataCollection = self.dataCollection;
        CourseTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueSemesterList2SchoolList"])
    {
        HomePageTableView *HomePageTableView = [segue destinationViewController];
        
        HomePageTableView.userInfo = self.schoolInfo.user;
        HomePageTableView.dataCollection = self.dataCollection;
        HomePageTableView.managedObjectContext = self.managedObjectContext;
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
    if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.section == 1)
    {
        // Delete the row from the data source
        SemesterDetails *semesterToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:semesterToDelete];
        [self.managedObjectContext save:nil];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
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
        [self performSegueWithIdentifier:@"segueEditSemester" sender:self];
    }
    else if (buttonIndex == 2)
    {
        SemesterDetails *semesterToDelete = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        [self.managedObjectContext deleteObject:semesterToDelete];
        [self.managedObjectContext save:nil];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier: @"segueCourseList" sender: self];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
