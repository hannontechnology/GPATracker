//
//  SyllabusEditTableView.m
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import "SyllabusEditTableView.h"
#import "CourseDetails.h"
#import "SyllabusDetails.h"
#import "DataCollection.h"
#import "CustomCellBackground.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SyllabusEditTableView ()

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SyllabusEditTableView
@synthesize sectionNameField;
@synthesize sectionPercentageField;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
    
    sectionNameField.inputAccessoryView = keyboardToolbar;
    sectionPercentageField.inputAccessoryView = keyboardToolbar;
    
    //cancelButton.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    if (self.setEditStatus != (NSString *)@"Edit")
    {
        return;
    }
    
    if (self.syllabusDetails == nil)
    {
        NSLog(@"Database Error: Could not connect to Database");
    }
    else
    {
        NSLog(@"Load Syllabus Information");
        self.headerText.title = @"Edit Section";
        self.sectionNameField.text = self.syllabusDetails.sectionName;
        self.sectionPercentageField.text = self.syllabusDetails.percentBreakdown.stringValue;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sectionNameField.delegate = self;
    self.sectionPercentageField.delegate = self;
    
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
    sectionNameField.inputAccessoryView = keyboardToolbar;
    sectionPercentageField.inputAccessoryView = keyboardToolbar;
}

- (void) doneKey:(id)sender
{
    if ([sectionNameField isFirstResponder])
        [sectionNameField resignFirstResponder];
    else if ([sectionPercentageField isFirstResponder])
        [sectionPercentageField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([sectionNameField isFirstResponder])
    {
        [sectionNameField resignFirstResponder];
        [sectionPercentageField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionPercentageField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionPercentageField isFirstResponder])
    {
        [sectionPercentageField resignFirstResponder];
        [sectionNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([sectionNameField isFirstResponder])
    {
        [sectionNameField resignFirstResponder];
        [sectionPercentageField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionPercentageField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionPercentageField isFirstResponder])
    {
        [sectionPercentageField resignFirstResponder];
        [sectionNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setHeaderText:nil];
    [self setSectionNameField:nil];
    [self setSectionPercentageField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)Accept:(id)sender
{
    if ([sectionNameField.text length] == 0)
    {
        NSLog(@"Section Name field is Required.");
        return;
    }
    if ([sectionPercentageField.text length] == 0)
    {
        NSLog(@"Course Units field is Required.");
        return;
    }
    
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveSyllabusBreakdown:sectionNameField.text courseDetails:self.courseDetails context:self.managedObjectContext];
    
    if (self.setEditStatus == (NSString *)@"Edit")
    {
        if (results == nil)
        {
            NSLog(@"Database Error: Could not connect to Database");
        }
        else
        {
            if ([results count] > 0)
            {
                NSLog(@"Save Course Information");
                self.syllabusDetails.sectionName = sectionNameField.text;
                self.syllabusDetails.percentBreakdown = [[NSDecimalNumber alloc] initWithString:sectionPercentageField.text];
                self.syllabusDetails.courseDetails = self.courseDetails;
                if ([self.managedObjectContext save:&error])
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
                }
                else
                {
                }
            }
        }
    }
    else if ([results count] == 0)
    {
        NSString *entityName = @"SyllabusDetails";
        self.syllabusDetails = [NSEntityDescription
                              insertNewObjectForEntityForName:entityName
                              inManagedObjectContext:self.managedObjectContext];
        self.syllabusDetails.sectionName = sectionNameField.text;
        self.syllabusDetails.percentBreakdown = [[NSDecimalNumber alloc] initWithString:sectionPercentageField.text];
        self.syllabusDetails.courseDetails = self.courseDetails;
        NSLog(@"About to save data = %@", self.syllabusDetails);
        if ([self.managedObjectContext save:&error])
        {
            [self.navigationController popViewControllerAnimated:YES];
            //[self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
        }
        else
        {
            NSLog(@"Add Section Failed! :%@", error.userInfo);
        }
    }
    else
    {
        NSLog(@"Section already taken.");
    }
} 

- (IBAction)Cancel:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Discard Changes" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    [popup showFromTabBar:self.view];
}

- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"User Click the Yes button");
        [self.navigationController popViewControllerAnimated:YES];
        //[self.parentViewController.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"User Click the No button");
        // Maybe do something else
        
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
}
@end
