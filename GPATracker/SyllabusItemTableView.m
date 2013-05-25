//
//  SyllabusTableView.m
//  GPATracker
//
//  Created by David Stevens on 13-03-24.
//
//

#import "SyllabusItemTableView.h"
#import "SyllabusDetails+Create.h"
#import "SyllabusItemDetails.h"
#import "SyllabusItemEditTableView.h"
#import "DataCollection.h"
#import "SyllabusItemTableCell1.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SyllabusItemTableView ()
@end

@implementation SyllabusItemTableView
@synthesize sectionNameField;
@synthesize sectionGradeField;
@synthesize sectionWeightField;

@synthesize syllabusDetails = _syllabusDetails;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;


- (void)setupFetchedResultsController
{
    // Create fetch request for the entity
    // Edit the entity name as appropriate
    NSString *entityName = @"SyllabusItemDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // Sort using the year / then name properties
    NSSortDescriptor *sortDescriptorSName = [[NSSortDescriptor alloc] initWithKey:@"syllabusDetails.sectionName" ascending:NO];
    //selector:@selector(localizedStandardCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptorSName, nil]];
    request.predicate = [NSPredicate predicateWithFormat: @"syllabusDetails = %@", self.syllabusDetails];
    NSLog(@"filtering data based on syllabusDetails = %@", self.syllabusDetails);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"syllabusDetails.sectionName" cacheName:nil];
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
    
    NSDecimalNumber *sumGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumTotal = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *currentGrade = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *zero = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    int count = 0;
    
    for (SyllabusItemDetails *item in self.syllabusDetails.syllabusItemDetails)
    {
        if (item.itemOutOf != nil && item.itemInclude.longValue == [NSNumber numberWithBool:YES].longValue)
        {
            sumTotal = [sumTotal decimalNumberByAdding:item.itemOutOf];
            count++;
        }
        if (item.itemScore != nil && item.itemInclude.longValue == [NSNumber numberWithBool:YES].longValue)
        {
            sumGrades = [sumGrades decimalNumberByAdding:item.itemScore];
            count++;
        }
    }
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    [nf setZeroSymbol:@"0.00"];
    
    self.sectionNameField.text = self.syllabusDetails.sectionName;
    self.sectionWeightField.text = [NSString stringWithFormat:@"%@%%", self.syllabusDetails.percentBreakdown.stringValue];
    if (sumTotal.longValue != zero.longValue)
    {
        currentGrade = [sumGrades decimalNumberByDividingBy:sumTotal];
        currentGrade = [currentGrade decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO]];
    }
    if (count > 0)
    {
        NSString *nsCurrentGrade  = [nf stringFromNumber:currentGrade];
        self.sectionGradeField.text = [NSString stringWithFormat:@"%@%%", nsCurrentGrade];
        self.syllabusDetails.sectionGrade = currentGrade;
    }
    else
    {
        NSString *nsCurrentGrade  = @"--";
        self.sectionGradeField.text = [NSString stringWithFormat:@"%@%%", nsCurrentGrade];
        self.syllabusDetails.sectionGrade = nil;
    }
    
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
    [self setSectionGradeField:nil];
    [self setSectionWeightField:nil];
    [self setSectionNameField:nil];
    
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
    static NSString *CellIdentifier = @"syllabusItemTableCell1";
    SyllabusItemTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SyllabusItemTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SyllabusItemDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // TODO: create class
    cell.cellLabel1.text = [selectedObject itemName];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    cell.cellLabel2.text = [dateFormatter stringFromDate:[selectedObject itemDueDate]];
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:1];
    [nf setMaximumFractionDigits:1];
    [nf setZeroSymbol:@"0.0"];

    NSDecimalNumber *currentGrade = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *zero = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSString *nsCurrentGrade;
    if ([selectedObject itemOutOf].longValue != zero.longValue)
    {
        currentGrade = [[selectedObject itemScore] decimalNumberByDividingBy:[selectedObject itemOutOf]];
        currentGrade = [currentGrade decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:100.00 exponent:0 isNegative:NO]];
        nsCurrentGrade = [nf stringFromNumber:currentGrade];
        cell.cellLabel3.text = [NSString stringWithFormat:@"%@%%", nsCurrentGrade];
    }
    else
    {
        nsCurrentGrade = @"--";
        cell.cellLabel3.text = [NSString stringWithFormat:@"%@%%", nsCurrentGrade];
    }
    
    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    
    // At end of function, right before return cell:
    if (selectedObject.itemInclude.longValue == [NSNumber numberWithBool:YES].longValue)
        cell.cellLabel3.backgroundColor = [UIColor clearColor];
    else
        cell.cellLabel3.backgroundColor = [UIColor lightGrayColor];

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
        SyllabusItemDetails *syllabusItemToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:syllabusItemToDelete];
        [self.managedObjectContext save:nil];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

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
    if ([segue.identifier isEqualToString:@"segueEditSyllabusItemFromList"])
    {
        SyllabusItemDetails *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];
        SyllabusItemEditTableView *syllabusItemEditTableView = [segue destinationViewController];
        
        syllabusItemEditTableView.syllabusItemDetails = selectedObject;
        syllabusItemEditTableView.syllabusDetails = self.syllabusDetails;
        syllabusItemEditTableView.dataCollection = self.dataCollection;
        syllabusItemEditTableView.managedObjectContext = self.managedObjectContext;
        syllabusItemEditTableView.setEditStatus = @"Edit";
    }
    else if ([segue.identifier isEqualToString:@"segueAddSyllabusItemFromList"])
    {
        SyllabusItemEditTableView *syllabusItemEditTableView = [segue destinationViewController];
        
        syllabusItemEditTableView.syllabusDetails = self.syllabusDetails;
        syllabusItemEditTableView.dataCollection = self.dataCollection;
        syllabusItemEditTableView.managedObjectContext = self.managedObjectContext;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEditing] == YES)
    {
        [self performSegueWithIdentifier:@"segueEditSyllabusItemFromList" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"segueEditSyllabusItemFromList" sender:self];
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
