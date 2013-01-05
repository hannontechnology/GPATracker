//
//  CourseTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseTableView.h"
#import "CourseDetails.h"
#import "GradingScheme+Create.h"
#import "CourseEditTableView.h"
#import "SemesterTableView.h"
#import "SemesterDetails.h"
#import "CourseListTableCell1.h"
#import "SchoolDetails+Create.h"

@interface CourseTableView ()

@end

@implementation CourseTableView
@synthesize semesterInfo = _semesterInfo;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize semesterNameText = _semesterNameText;
@synthesize semesterCourseCount = _semesterCourseCount;
@synthesize semesterCreditHours = _semesterCreditHours;
@synthesize semesterGPA = _semesterGPA;

- (void)setupFetchedResultsController
{
    // Create fetch request for the entity
    // Edit the entity name as appropriate
    NSString *entityName = @"CourseDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorYear = [[NSSortDescriptor alloc] initWithKey:@"courseCode" ascending:YES];
    NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"courseName" ascending:YES selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorYear, sortDescriptorName, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"semesterDetails = %@", self.semesterInfo];
    NSLog(@"filtering data based on semesterDetails = %@", self.semesterInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

-(IBAction)back
{
    [self performSegueWithIdentifier: @"segueCourseList2SemesterList" sender: self];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    [super viewWillAppear:(BOOL)animated];

    self.semesterNameText.text = [NSString stringWithFormat:@"%@ - %@", [self.semesterInfo semesterName], [self.semesterInfo semesterYear]];
    int courseCount = [self.semesterInfo.courseDetails count];
    NSDecimalNumber *sumCredits = [self.semesterInfo valueForKeyPath:@"courseDetails.@sum.units"];
    NSDecimalNumber *sumUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    for (CourseDetails *item in self.semesterInfo.courseDetails)
    {
        sumUnits = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
        sumGrades = [sumGrades decimalNumberByAdding:[item.actualGradeGPA.gPA decimalNumberByMultiplyingBy:sumUnits]];
    }
    NSDecimalNumber *gPA;
    if ([sumCredits longValue] == 0)
    {
        gPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        gPA = [sumGrades decimalNumberByDividingBy:sumCredits];
    }

    self.semesterCourseCount.text = [NSString stringWithFormat:@"Course Count: %d",courseCount];
    self.semesterCreditHours.text = [NSString stringWithFormat:@"Credit Hours: %@", sumCredits.stringValue];
    self.semesterGPA.text = [NSString stringWithFormat:@"%@",gPA.stringValue];
    
    [self setupFetchedResultsController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
    //Custom Back Button
    UIButton* backButton = [UIButton buttonWithType:101]; // left-pointing shape!
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Semester List" forState:UIControlStateNormal];
    // create button item -- possible because UIButton subclasses UIView!
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    // add to toolbar, or to a navbar (you should only have one of these!)
    self.navigationItem.leftBarButtonItem = backItem;
    */

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setSemesterNameText:nil];
    [self setSemesterCourseCount:nil];
    [self setSemesterCreditHours:nil];
    [self setSemesterGPA:nil];
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
    static NSString *CellIdentifier = @"courseListTableCell1";
    CourseListTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[CourseListTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // TODO: create class courseListCell2 and include custom labels for display to cell
    cell.cellLabel1.text = [selectedObject courseCode];
    cell.cellLabel2.text = [selectedObject courseName];
    cell.cellLabel3.text = [NSString stringWithFormat:@"Credit Hours: %@", [selectedObject units].stringValue];
    cell.cellLabelGPA.text = selectedObject.actualGradeGPA.letterGrade;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueAddCourse"])
    {
        // Use this code if going to a navigation controller before accessing destination screen
        //UINavigationController *navCon = [segue destinationViewController];
        //CourseEditTableView *CourseEditTableView = [navCon.viewControllers objectAtIndex:0];
        CourseEditTableView *CourseEditTableView = [segue destinationViewController];
        
        CourseEditTableView.semesterDetails = self.semesterInfo;
        CourseEditTableView.dataCollection = self.dataCollection;
        CourseEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueEditCourse"])
    {
        CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        CourseEditTableView *CourseEditTableView = [segue destinationViewController];
        
        CourseEditTableView.courseDetails = selectedObject;
        CourseEditTableView.semesterDetails = self.semesterInfo;
        CourseEditTableView.dataCollection = self.dataCollection;
        CourseEditTableView.managedObjectContext = self.managedObjectContext;
        CourseEditTableView.setEditStatus = @"Edit";
    }
    else if ([segue.identifier isEqualToString:@"segueCourseList2SemesterList"])
    {
        SemesterTableView *SemesterTableView = [segue destinationViewController];
        
        SemesterTableView.schoolInfo = self.semesterInfo.schoolDetails;
        SemesterTableView.userInfo = self.semesterInfo.schoolDetails.user;
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
        // Delete the row from the data source
        CourseDetails *courseToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:courseToDelete];
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
        [self performSegueWithIdentifier:@"segueEditCourse" sender:self];
    }
    else if (buttonIndex == 2)
    {
        CourseDetails *courseToDelete = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        [self.managedObjectContext deleteObject:courseToDelete];
        [self.managedObjectContext save:nil];
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier: @"segueEditCourse" sender: self];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
