//
//  SyllabusListTableView.m
//  GPATracker
//
//  Created by David Stevens on 13-03-24.
//
//

#import "SyllabusListTableView.h"
#import "CourseDetails.h"
#import "SyllabusDetails+Create.h"
#import "SyllabusItemDetails+Create.h"
#import "GradingScheme+Create.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "CourseTableView.h"
#import "CourseListTableView.h"
#import "HomePageTabViewController.h"
#import "SemesterDetails.h"
#import "LoginView.h"
#import "ProfileEditTableView.h"
#import "SyllabusListTableCell1.h"
#import "SyllabusEditTableView.h"
#import "SyllabusItemTableView.h"
#import "SchoolDetails+Create.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SyllabusListTableView ()
@end

@implementation SyllabusListTableView

@synthesize userInfo = _userInfo;
@synthesize courseDetails = _courseDetails;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize courseCodeText = _courseCodeText;
@synthesize courseNameText = _courseNameText;
@synthesize courseDesiredGradeText = _courseDesiredGradeText;
@synthesize courseMinPercentText = _courseMinPercentText;
@synthesize courseMaxPercentText = _courseMaxPercentText;
@synthesize courseCreditsText = _courseCreditsText;
@synthesize courseTotalWeightText = _courseTotalWeightText;

- (void)setupFetchedResultsController
{
    // Create fetch request for the entity
    // Edit the entity name as appropriate
    NSString *entityName = @"SyllabusDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorSName = [[NSSortDescriptor alloc] initWithKey:@"sectionName" ascending:YES];
    //selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorSName, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"courseDetails = %@", self.courseDetails];
    NSLog(@"filtering data based on courseDetails = %@", self.courseDetails);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"groupName" cacheName:nil];
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

- (IBAction)GotoHomePage:(id)sender {
    self.viewType = @"Schools";
    [self performSegueWithIdentifier:@"segueSyllabusList2HomePage" sender: self];
}

- (IBAction)GotoSemesterList:(id)sender {
    self.viewType = @"Semesters";
    [self performSegueWithIdentifier:@"segueSyllabusList2HomePage" sender: self];
}

- (IBAction)GotoCourseList:(id)sender {
    self.viewType = @"Courses";
    [self performSegueWithIdentifier:@"segueSyllabusList2HomePage" sender: self];
}

- (IBAction)GotoCalendar:(id)sender {
    self.viewType = @"Calendar";
    [self performSegueWithIdentifier:@"segueSyllabusList2HomePage" sender: self];
}

- (IBAction)EditProfile:(id)sender {
    [self performSegueWithIdentifier: @"segueSyllabusList2EditProfile" sender: self];
}

- (IBAction)Logout:(id)sender {
    [self performSegueWithIdentifier: @"segueSyllabusListLogout" sender: self];
}

-(IBAction)back
{
    //[self performSegueWithIdentifier: @"segueSemesterList2SchoolList" sender: self];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    [super viewWillAppear:(BOOL)animated];

    NSDecimalNumber *sumWeight = [self.courseDetails valueForKeyPath:@"syllabusDetails.@sum.percentBreakdown"];
    
    self.courseCodeText.text = self.courseDetails.courseCode;
    self.courseNameText.text = self.courseDetails.courseName;
    self.courseDesiredGradeText.text = self.courseDetails.desiredGradeGPA.letterGrade;
    self.courseMinPercentText.text = [NSString stringWithFormat:@"%@%%", self.courseDetails.desiredGradeGPA.minGrade.stringValue];
    self.courseCreditsText.text = [NSString stringWithFormat:@"%@", [self.courseDetails units].stringValue];
    self.courseTotalWeightText.text = [NSString stringWithFormat:@"%@%%", sumWeight.stringValue];
    if ([sumWeight.stringValue isEqualToString:@"100"])
        [self.courseTotalWeightText setTextColor:[UIColor blackColor]];
    else
        [self.courseTotalWeightText setTextColor:[UIColor redColor]];
    
    NSDecimalNumber *sumTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumMax = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    for (SyllabusDetails *item in self.courseDetails.syllabusDetails)
    {
        if (item.percentBreakdown != nil)
        {
            NSDecimalNumber *sectionPercent = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            NSDecimalNumber *sectionTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            NSDecimalNumber *itemCount = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            NSDecimalNumber *itemCount1 = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            NSDecimalNumber *sectionScore = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            sectionPercent = [item.percentBreakdown decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO]];
            for (SyllabusItemDetails *item2 in item.syllabusItemDetails)
            {
                if (item2.itemScore != nil && item2.itemOutOf != nil && item2.itemScore.longValue != 0 && item2.itemOutOf.longValue != 0)
                {
                    NSDecimalNumber *itemTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
                    itemTotal = [item2.itemScore decimalNumberByDividingBy:item2.itemOutOf];
                    itemTotal = [itemTotal decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO]];
                    itemCount = [itemCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
                    itemCount1 = [itemCount1 decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
                    sectionTotal = [sectionTotal decimalNumberByAdding:itemTotal];
                    sectionScore = [sectionScore decimalNumberByAdding:itemTotal];
                }
                else
                {
                    NSDecimalNumber *itemTotal = [NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO];
                    itemCount1 = [itemCount1 decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
                    sectionScore = [sectionScore decimalNumberByAdding:itemTotal];
                }
            }
            if (itemCount.longValue != 0)
                sectionTotal = [sectionTotal decimalNumberByDividingBy:itemCount];
            else
                sectionTotal = [NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO];

            if (itemCount1.longValue != 0)
                sectionScore = [sectionScore decimalNumberByDividingBy:itemCount1];
            else
                sectionScore = [NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO];
            
            sectionTotal = [sectionTotal decimalNumberByMultiplyingBy:sectionPercent];
            sectionScore = [sectionScore decimalNumberByMultiplyingBy:sectionPercent];
            sumTotal = [sumTotal decimalNumberByAdding:sectionTotal];
            sumMax = [sumMax decimalNumberByAdding:sectionScore];
        }
    }
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:0];
    [nf setMaximumFractionDigits:0];
    [nf setZeroSymbol:@"0"];
    
    NSString *nsPossibleGrade = [nf stringFromNumber:sumTotal];
    NSString *nsMaximumGrade = [nf stringFromNumber:sumMax];
    
    self.courseMaxPercentText.text = [NSString stringWithFormat:@"%@%%", nsMaximumGrade];
    self.courseCurrPercentText.text = [NSString stringWithFormat:@"%@%%", nsPossibleGrade];
    
    [self setupFetchedResultsController];    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setBtnLogout:nil];
    [self setBtnProfile:nil];
    [self setBtnCalendar:nil];
    [self setBtnCourseList:nil];
    [self setBtnSemesterList:nil];
    [self setBtnHomePage:nil];
    [self setCourseCurrPercentText:nil];
    [self setCourseTotalWeightText:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"syllabusListTableCell1";
    SyllabusListTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SyllabusListTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SyllabusDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // TODO: create class
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:1];
    [nf setMaximumFractionDigits:1];
    [nf setZeroSymbol:@"0.0"];
    
    cell.cellLabel2.text = [selectedObject sectionName];
    cell.cellLabel1.text = [NSString stringWithFormat:@"%@%%", [selectedObject percentBreakdown].stringValue];
    NSDecimalNumber *sectionTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *itemCount = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *itemCount1 = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sectionScore = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
 
    for (SyllabusItemDetails *item2 in selectedObject.syllabusItemDetails)
    {
        if (item2.itemScore != nil && item2.itemOutOf != nil && item2.itemScore.longValue != 0 && item2.itemOutOf.longValue != 0)
        {
            NSDecimalNumber *itemTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
            itemTotal = [item2.itemScore decimalNumberByDividingBy:item2.itemOutOf];
            itemTotal = [itemTotal decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO]];
            itemCount = [itemCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
            itemCount1 = [itemCount1 decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
            sectionTotal = [sectionTotal decimalNumberByAdding:itemTotal];
            sectionScore = [sectionScore decimalNumberByAdding:itemTotal];
        }
        else
        {
            NSDecimalNumber *itemTotal = [NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO];
            itemCount1 = [itemCount1 decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:1.00 exponent:0 isNegative:NO]];
            sectionScore = [sectionScore decimalNumberByAdding:itemTotal];
        }
    }
    if (itemCount.longValue != 0)
        sectionTotal = [sectionTotal decimalNumberByDividingBy:itemCount];
    
    if (itemCount1.longValue != 0)
        sectionScore = [sectionScore decimalNumberByDividingBy:itemCount1];
    else
        sectionScore = [NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO];
    
    NSString *nsSectionTotal = [nf stringFromNumber:sectionTotal];
    NSString *nsSectionMax = [nf stringFromNumber:sectionScore];
    
    cell.cellLabel3.text = [NSString stringWithFormat:@"%@%%", nsSectionTotal];
    cell.cellLabel4.text = [NSString stringWithFormat:@"%@%%", nsSectionMax];

    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    
    // At end of function, right before return cell:
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
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
        SyllabusDetails *syllabusToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:syllabusToDelete];
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
        [self performSegueWithIdentifier:@"segueEditSyllabusFromList" sender:self];
    }
    else if (buttonIndex == 2)
    {
        SyllabusDetails *syllabusToDelete = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        [self.managedObjectContext deleteObject:syllabusToDelete];
        [self.managedObjectContext save:nil];
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueSyllabusList2SyllabusItems"])
    {
        SyllabusDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SyllabusItemTableView *syllabusItemTableView = [segue destinationViewController];
        syllabusItemTableView.syllabusDetails = selectedObject;
        syllabusItemTableView.dataCollection = self.dataCollection;
        syllabusItemTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueAddSyllabusFromList"])
    {
        SyllabusEditTableView *syllabusEditTableView = [segue destinationViewController];
        syllabusEditTableView.courseDetails = self.courseDetails;
        syllabusEditTableView.DataCollection = self.dataCollection;
        syllabusEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueEditSyllabusFromList"])
    {
        SyllabusDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SyllabusEditTableView *syllabusEditTableView = [segue destinationViewController];
        syllabusEditTableView.syllabusDetails = selectedObject;
        syllabusEditTableView.courseDetails = self.courseDetails;
        syllabusEditTableView.DataCollection = self.dataCollection;
        syllabusEditTableView.managedObjectContext = self.managedObjectContext;
        syllabusEditTableView.setEditStatus = @"Edit";
    }
    else if ([segue.identifier isEqualToString:@"segueSyllabusList2HomePage"])
    {
        HomePageTabViewController *homePageTabViewController = [segue destinationViewController];
        
        homePageTabViewController.userInfo = self.courseDetails.semesterDetails.schoolDetails.user;
        homePageTabViewController.dataCollection = self.dataCollection;
        homePageTabViewController.managedObjectContext = self.managedObjectContext;
        homePageTabViewController.displayType = self.viewType;
        if ([self.viewType isEqual:@"Schools"])
            [homePageTabViewController viewSchools];
        else if ([self.viewType isEqual:@"Semesters"])
            [homePageTabViewController viewSemesters];
        else if ([self.viewType isEqual:@"Courses"])
            [homePageTabViewController viewCourses];
        else if ([self.viewType isEqual:@"Calendar"])
            [homePageTabViewController viewCalendar];
    }
	else if ([segue.identifier isEqualToString:@"segueSyllabusListLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.setLogoutStatus = @"Logout";
        LoginView.userInfo = self.courseDetails.semesterDetails.schoolDetails.user;
        LoginView.dataCollection = self.dataCollection;
        LoginView.managedObjectContext = self.managedObjectContext;
	}
    else if ([segue.identifier isEqualToString:@"segueSyllabusList2EditProfile"])
    {
        ProfileEditTableView *ProfileEditTableView = [segue destinationViewController];
        
        ProfileEditTableView.setEditStatus = @"Edit";
        ProfileEditTableView.userInfo = self.courseDetails.semesterDetails.schoolDetails.user;
        ProfileEditTableView.dataCollection = self.dataCollection;
        ProfileEditTableView.managedObjectContext = self.managedObjectContext;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEditing] == YES)
    {
        [self performSegueWithIdentifier:@"segueSyllabusList2SyllabusItems" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"segueSyllabusList2SyllabusItems" sender:self];
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
