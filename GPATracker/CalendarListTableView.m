//
//  CourseListTableView.m
//  GPATracker
//
//  Created by Terry Hannon on 13-02-08.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "CalendarListTableView.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "CourseTableView.h"
#import "CourseEditTableView.h"
#import "SemesterDetails+Create.h"
#import "CourseDetails+Create.h"
#import "CalendarListTableCell1.h"
#import "SchoolDetails+Create.h"
#import "GradingScheme+Create.h"
#import "SyllabusListTableView.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface CalendarListTableView ()
@end

@implementation CalendarListTableView
@synthesize userInfo = _userInfo;
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
    NSString *entityName = @"CourseDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorYear = [[NSSortDescriptor alloc] initWithKey:@"semesterDetails.semesterYear" ascending:NO];
    NSSortDescriptor *sortDescriptorSCode = [[NSSortDescriptor alloc] initWithKey:@"semesterDetails.semesterCode" ascending:NO];
    NSSortDescriptor *sortDescriptorCCode = [[NSSortDescriptor alloc] initWithKey:@"courseCode" ascending:YES];
    //selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorYear, sortDescriptorSCode, sortDescriptorCCode, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"semesterDetails.schoolDetails = %@", self.schoolInfo];
    NSLog(@"filtering data based on schoolDetails = %@", self.schoolInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
}

-(CGFloat) tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section
{
    return [[CustomFooter alloc] init];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    if (section == 1)
    {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
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
    [self DisplayInfo];
}

- (void)DisplayInfo
{
    self.schoolNameText.text = self.schoolInfo.schoolName;
    self.schoolDescText.text = self.schoolInfo.schoolDetails;
    self.schoolYearsText.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];

    NSDecimalNumber *sumCredits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];//[selectedObject valueForKeyPath:@"courseDetails.@sum.units"];
    NSDecimalNumber *sumUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    for (SemesterDetails *semester in self.schoolInfo.semesterDetails)
    {
        sumCredits = [sumCredits decimalNumberByAdding:[semester valueForKeyPath:@"courseDetails.@sum.units"]];
        for (CourseDetails *item in semester.courseDetails)
        {
            if (item.actualGradeGPA != nil && item.includeInGPA == [NSNumber numberWithInt:1] && item.actualGradeGPA.includeInGPA == [NSNumber numberWithInt:1])
            {
                NSDecimalNumber *units = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
                sumGrades = [sumGrades decimalNumberByAdding:[item.actualGradeGPA.gPA decimalNumberByMultiplyingBy:units]];
                sumUnits = [sumUnits decimalNumberByAdding:units];
            }
        }
    }
    NSDecimalNumber *gPA;
    if ([sumUnits longValue] == 0)
    {
        gPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        gPA = [sumGrades decimalNumberByDividingBy:sumUnits];
    }
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    [nf setZeroSymbol:@"0.00"];
    NSString *ns  = [nf stringFromNumber:gPA];
    
    //cell.cellLabel1.text = [NSString stringWithFormat:@"%@ - %@", [selectedObject semesterName], [selectedObject semesterYear]];
    //cell.cellLabel2.text = [NSString stringWithFormat:@"Course Count: %d",courseCount];
    //self. = [NSString stringWithFormat:@"Credit Hours: %@", sumCredits.stringValue];
    self.schoolCGPAText.text = [NSString stringWithFormat:@"%@",ns];
    
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
    static NSString *CellIdentifier = @"calendarListTableCell1";
    CalendarListTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[CalendarListTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        ((CustomCellBackground *)cell.selectedBackgroundView).selected = YES;
    }
    
    CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // TODO: create class courseListCell2 and include custom labels for display to cell
    cell.cellLabel1.text = [selectedObject courseCode];
    cell.cellLabel2.text = [selectedObject courseName];
    cell.cellLabel3.text = [NSString stringWithFormat:@"Credit Hours: %@", [selectedObject units].stringValue];
    if (selectedObject.actualGradeGPA != nil)
    {
        cell.cellLabelGPA.text = selectedObject.actualGradeGPA.letterGrade;
    }
    else
    {
        cell.cellLabelGPA.text = @"";
    }
    
    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueAddCourse"])
    {
        CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CourseEditTableView *CourseEditTableView = [segue destinationViewController];
        
        CourseEditTableView.semesterDetails = selectedObject.semesterDetails;
        CourseEditTableView.dataCollection = self.dataCollection;
        CourseEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueHomePageEditCourse"])
    {
        CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        CourseEditTableView *CourseEditTableView = [segue destinationViewController];
        
        //CourseEditTableView.userInfo = self.userInfo;
        CourseEditTableView.courseDetails = selectedObject;
        CourseEditTableView.semesterDetails = selectedObject.semesterDetails;
        CourseEditTableView.dataCollection = self.dataCollection;
        CourseEditTableView.managedObjectContext = self.managedObjectContext;
        CourseEditTableView.setEditStatus = @"Edit";
    }
    else if ([segue.identifier isEqualToString:@"segueCourseList"])
    {
        SemesterDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        CourseTableView *CourseTableView = [segue destinationViewController];
        
        CourseTableView.semesterInfo = selectedObject;
        CourseTableView.dataCollection = self.dataCollection;
        CourseTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueCourseList2SyllabusList"])
    {
        CourseDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SyllabusListTableView *SyllabusListTableView = [segue destinationViewController];
        
        SyllabusListTableView.courseDetails = selectedObject;
        //SyllabusEditTableView.semesterDetails = self.semesterInfo;
        SyllabusListTableView.dataCollection = self.dataCollection;
        SyllabusListTableView.managedObjectContext = self.managedObjectContext;
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    if (editingStyle == UITableViewCellEditingStyleDelete) // && indexPath.section == 1)
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

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO; //YES;
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
        [self performSegueWithIdentifier:@"segueHomePageEditCourse" sender:self];
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

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEditing] == YES)
    {
        [self performSegueWithIdentifier: @"segueHomePageEditCourse" sender: self];
    }
    else
    {
        [self performSegueWithIdentifier: @"segueCourseList2SyllabusList" sender: self];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
