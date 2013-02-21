//
//  GradingSchemeTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "GradingSchemeTableView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "GradingScheme+Create.h"
#import "SchoolListTableView.h"
#import "SemesterEditTableView.h"
#import "GradingSchemeCell1.h"

@interface GradingSchemeTableView ()
- (IBAction)Save:(id)sender;
@end

@implementation GradingSchemeTableView
@synthesize userInfo = _userInfo;
@synthesize schoolInfo = _schoolInfo;
@synthesize gradingInfo = _gradingInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize tableView = _tableView;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize selectedSection = _selectedSection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupFetchedResultsController
{
    NSString *entityName = @"GradingScheme";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"gPA" ascending:NO]];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"letterGrade" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat: @"school = %@", self.schoolInfo];
    NSLog(@"filtering data based on school = %@", self.schoolInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"isPassFail" cacheName:@"gradeCache"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *sectionName;
    
    if (section == 0)
        sectionName = @"Standard Grades";
    else
        sectionName = @"Pass/Fail Grades";
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gradingSchemeTableCell1";
    GradingSchemeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[GradingSchemeCell1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.cellLabel1.text = [selectedObject letterGrade];
    NSDecimalNumber *gPA = [selectedObject gPA];
    cell.cellField1.text = gPA.stringValue;
    NSDecimalNumber *minGrade = [selectedObject minGrade];
    cell.minGrade.text = minGrade.stringValue;
    NSDecimalNumber *maxGrade = [selectedObject maxGrade];
    cell.maxGrade.text = maxGrade.stringValue;
    
    if (selectedObject.includeInGPA == [NSNumber numberWithInt:1])
    {
        UIImage * btnImage1 = [UIImage imageNamed:@"Checkbox_checked.png"];
        [cell.btnInGPA setImage:btnImage1 forState:UIControlStateNormal];
    }
    else
    {
        UIImage * btnImage1 = [UIImage imageNamed:@"Checkbox_unchecked.png"];
        [cell.btnInGPA setImage:btnImage1 forState:UIControlStateNormal];
    }
    [cell.btnInGPA setTag:indexPath.row];
    [cell.cellField1 setTag:indexPath.row];
    [cell.minGrade setTag:indexPath.row];
    [cell.maxGrade setTag:indexPath.row];
    cell.cellField1.inputAccessoryView = keyboardToolbar;
    cell.minGrade.inputAccessoryView = keyboardToolbar;
    cell.maxGrade.inputAccessoryView = keyboardToolbar;
    cell.cellField1.delegate = self;
    cell.minGrade.delegate = self;
    cell.maxGrade.delegate = self;
    cell.indexPath = indexPath;
    
    //NSLog(@"Row: %d, Section: %d",indexPath.row, indexPath.section);
    
    return cell;
}

-(IBAction)checkIsGPA:(id)sender
{
    UIButton *tmp = (UIButton *)sender;
    UIView *tmpCell = tmp.superview.superview;
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)tmpCell;

    if (cell == nil)
        return;
    
    if (tmp.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
    {
        UIImage * btnImage1 = [UIImage imageNamed:@"Checkbox_unchecked.png"];
        [tmp setImage:btnImage1 forState:UIControlStateNormal];
    }
    else
    {
        UIImage * btnImage1 = [UIImage imageNamed:@"Checkbox_checked.png"];
        [tmp setImage:btnImage1 forState:UIControlStateNormal];
    }

    GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:cell.indexPath];
    NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);
    
    selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
    selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:cell.minGrade.text];
    selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:cell.maxGrade.text];
    if (cell.btnInGPA.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:1];
    }
    else
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:0];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (keyboardToolbar == nil)
    {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 44.0)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.alpha = 0.2;
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(prevField:)];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextField:)];
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneKey:)];
        
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:prevButton, nextButton, extraSpace, doneButton, nil]];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Save:(id)sender
{
    NSError *error = nil;
    /*
    for (int i=0;i<[self.tableView numberOfRowsInSection:0];i++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
        GradingSchemeCell1 *cell = (GradingSchemeCell1 *)cellTmp;
        if (cell == nil)
        {
            //NSLog(@"Index Row: %d",[ip row]);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0]-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
            cell = (GradingSchemeCell1 *)cellTmp;
            if (cell == nil)
            {
                //NSLog(@"Index Row: %d",[ip row]);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
                cell = (GradingSchemeCell1 *)cellTmp;
            }
        }
        GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:ip];
        NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);

        selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
        selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:cell.minGrade.text];
        selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:cell.maxGrade.text];
        if (cell.btnInGPA.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
        {
            selectedObject.includeInGPA = [NSNumber numberWithInt:1];
        }
        else
        {
            selectedObject.includeInGPA = [NSNumber numberWithInt:0];
        }
    }

    for (int i=0;i<[self.tableView numberOfRowsInSection:1];i++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:1];
        UITableViewCell *cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
        GradingSchemeCell1 *cell = (GradingSchemeCell1 *)cellTmp;
        if (cell == nil)
        {
            //NSLog(@"Index Row: %d",[ip row]);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:1]-1 inSection:1];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
            cell = (GradingSchemeCell1 *)cellTmp;
            if (cell == nil)
            {
                //NSLog(@"Index Row: %d",[ip row]);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                cellTmp = [[self tableView] cellForRowAtIndexPath:ip];
                cell = (GradingSchemeCell1 *)cellTmp;
            }
        }
        GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:ip];
        NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);
        
        selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
        selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:cell.minGrade.text];
        selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:cell.maxGrade.text];
        if (cell.btnInGPA.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
        {
            selectedObject.includeInGPA = [NSNumber numberWithInt:1];
        }
        else
        {
            selectedObject.includeInGPA = [NSNumber numberWithInt:0];
        }
    }
    */
    //NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.gradingInfo context:self.managedObjectContext];

    if (self.gradingInfo == nil)
    {
        NSLog(@"Error: Could not connect to database.");
    }
    //if ([results count] != 0)
    //{
        [self.managedObjectContext save:&error];
    //}

    [self performSegueWithIdentifier:@"segueGrading2Home" sender:self];
}
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueGrading2Home"])
    {
        SchoolListTableView *SchoolListTableView = [segue destinationViewController];
        SchoolListTableView.userInfo = self.userInfo;
        SchoolListTableView.dataCollection = self.dataCollection;
        SchoolListTableView.managedObjectContext = self.managedObjectContext;
    }
}
- (void) doneKey:(id)sender
{
    UITableViewCell *cellTmp = [[self tableView] cellForRowAtIndexPath:self.selectedIndexPath];
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)cellTmp;
    if (cell == nil)
    {
        return;
    }
    if ([cell.cellField1 isFirstResponder])
        [cell.cellField1 resignFirstResponder];
    else if([cell.minGrade isFirstResponder])
        [cell.minGrade resignFirstResponder];
    else if([cell.maxGrade isFirstResponder])
        [cell.maxGrade resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    UITableViewCell *cellTmp = [[self tableView] cellForRowAtIndexPath:self.selectedIndexPath];
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)cellTmp;

    int selectedSection = self.selectedIndexPath.section;
    
    if (cell == nil)
    {
        return;
    }
    if ([cell.cellField1 isFirstResponder])
    {
        [cell.cellField1 resignFirstResponder];
        int row = cell.maxGrade.tag;
        row --;
        
        if (row < 0)
        {
            if (selectedSection == 0)
                selectedSection = 1;
            else
                selectedSection = 0;

            row = [self.tableView numberOfRowsInSection:selectedSection] - 1;
        }
        
        cellTmp = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:selectedSection]];
        cell = (GradingSchemeCell1 *)cellTmp;
        [cell.maxGrade becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([cell.minGrade isFirstResponder])
    {
        [cell.minGrade resignFirstResponder];
        [cell.cellField1 becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([cell.maxGrade isFirstResponder])
    {
        [cell.maxGrade resignFirstResponder];
        [cell.minGrade becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    UITableViewCell *cellTmp = [[self tableView] cellForRowAtIndexPath:self.selectedIndexPath];
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)cellTmp;
    GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:cell.indexPath];
    NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);

    int selectedSection = self.selectedIndexPath.section;

    if (cell == nil)
    {
        return;
    }
    if ([cell.cellField1 isFirstResponder])
    {
        [cell.cellField1 resignFirstResponder];
//        NSDecimalNumber *tmpGPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
//        selectedObject.gPA = tmpGPA;
//        BOOL *bTest = [cell.minGrade canBecomeFirstResponder];
        [cell.minGrade becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([cell.minGrade isFirstResponder])
    {
        [cell.minGrade resignFirstResponder];
        [cell.maxGrade becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([cell.maxGrade isFirstResponder])
    {
        [cell.maxGrade resignFirstResponder];
        int row = cell.maxGrade.tag;
        row ++;
        
        if (row >= [self.tableView numberOfRowsInSection:selectedSection])
        {
            if (selectedSection == 0)
                selectedSection = 1;
            else
                selectedSection = 0;
            
            row = 0;
        }
        
        cellTmp = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:selectedSection]];
        cell = (GradingSchemeCell1 *)cellTmp;
        [cell.cellField1 becomeFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView *tmpCell = textField.superview.superview;
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)tmpCell;
    
    if (cell == nil)
        return true;

    self.selectedIndexPath = cell.indexPath;
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIView *tmpCell = textField.superview.superview;
    GradingSchemeCell1 *cell = (GradingSchemeCell1 *)tmpCell;
    
    if (cell == nil)
        return; // true;
    
    GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:cell.indexPath];
    NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);
    
    if (textField == cell.cellField1)
        selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:textField.text];
    else if (textField == cell.minGrade)
        selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:textField.text];
    else if (textField == cell.maxGrade)
        selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:textField.text];
    /*
    selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
    selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:cell.minGrade.text];
    selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:cell.maxGrade.text];
    if (cell.btnInGPA.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:1];
    }
    else
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:0];
    }
    */
    return; // true;
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
