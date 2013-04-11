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
#import "GradingScheme+Create.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "CourseTableView.h"
#import "CourseListTableView.h"
#import "SyllabusListTableCell1.h"
#import "CourseEditTableView.h"
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

- (void)setupFetchedResultsController
{
    // Create fetch request for the entity
    // Edit the entity name as appropriate
    NSString *entityName = @"SyllabusDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorSName = [[NSSortDescriptor alloc] initWithKey:@"sectionName" ascending:NO];
    //selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorSName, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"courseDetails = %@", self.courseDetails];
    NSLog(@"filtering data based on courseDetails = %@", self.courseDetails);
    
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
    //[self performSegueWithIdentifier: @"segueSemesterList2SchoolList" sender: self];
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    [super viewWillAppear:(BOOL)animated];
    
    self.courseCodeText.text = self.courseDetails.courseCode;
    self.courseNameText.text = self.courseDetails.courseName;
    self.courseDesiredGradeText.text = self.courseDetails.desiredGradeGPA.letterGrade;
    self.courseMinPercentText.text = [NSString stringWithFormat:@"%@%%", self.courseDetails.desiredGradeGPA.minGrade.stringValue];
    self.courseCreditsText.text = [NSString stringWithFormat:@"Credit Hours: %@", [self.courseDetails units].stringValue];
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    [nf setZeroSymbol:@"0.00"];
    
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
    cell.cellLabel1.text = [selectedObject sectionName];
    cell.cellLabel3.text = [NSString stringWithFormat:@"%@%%", [selectedObject percentBreakdown].stringValue];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueSyllabusList2SyllabusDetails"])
    {
        SyllabusDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SyllabusListTableView *SyllabusListTableView = [segue destinationViewController];
        
        //SyllabusEditTableView.courseDetails = selectedObject;
        //SyllabusEditTableView.semesterDetails = self.semesterInfo;
        SyllabusListTableView.dataCollection = self.dataCollection;
        SyllabusListTableView.managedObjectContext = self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"segueAddSyllabusFromList"])
    {
        SyllabusListTableView *syllabusListTableView = [segue destinationViewController];
        syllabusListTableView.courseDetails = self.courseDetails;
        syllabusListTableView.DataCollection = self.dataCollection;
        syllabusListTableView.managedObjectContext = self.managedObjectContext;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEditing] == YES)
    {
        [self performSegueWithIdentifier:@"segueSyllabusList2SyllabusDetails" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"segueSyllabusList2SyllabusDetails" sender:self];
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
