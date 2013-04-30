//
//  SyllabusEditTableView.m
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import "SyllabusItemEditTableView.h"
#import "SyllabusItemDetails.h"
#import "SyllabusDetails.h"
#import "DataCollection.h"
#import "CustomCellBackground.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SyllabusItemEditTableView ()
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property CGRect pickerViewShownFrame;
@property CGRect pickerViewHiddenFrame;

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SyllabusItemEditTableView
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize syllabusDetails = _syllabusDetails;
@synthesize syllabusItemDetails = _syllabusItemDetails;

@synthesize datePicker;
@synthesize pickerView = _pickerView;
@synthesize pickerViewShownFrame = _pickerViewShownFrame;
@synthesize pickerViewHiddenFrame = _pickerViewHiddenFrame;


// Some values that will be handy later on.
static const CGFloat kPickerDefaultWidth = 320.f;
static const CGFloat kPickerDefaultHeight = 216.f;
static const NSTimeInterval kPickerAnimationTime = 0.333;


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
    
    self.pickerViewShownFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height - kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    self.pickerViewHiddenFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height + kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    
    // Set up the initial state of the picker.
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.date = [NSDate date];
    self.datePicker.frame = self.pickerViewShownFrame;
    //self.pickerView = [[UIPickerView alloc] init];
    //self.pickerView.frame = self.pickerViewShownFrame;
    //self.pickerView.delegate = self;
    //self.pickerView.dataSource = datePicker.date;
    //self.pickerView.showsSelectionIndicator = YES;

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
    
    self.itemNameField.inputAccessoryView = keyboardToolbar;
    self.itemDueDateField.inputAccessoryView = keyboardToolbar;
    self.itemDueDateField.inputView = self.datePicker;
    
    //cancelButton.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.hidesBackButton = YES;
    
    if (self.setEditStatus != (NSString *)@"Edit")
    {
        NSString *itemName;
        int itemCount;
        itemCount = [self.syllabusDetails.syllabusItemDetails count];
        itemCount ++;
        itemName = [NSString stringWithFormat:@"%@ #%d",self.syllabusDetails.sectionName, itemCount];
        self.itemNameField.text = itemName;
        self.itemNameField.enabled = NO;
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        [datePicker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
        self.itemDueDateField.text = [dateFormatter stringFromDate:self.datePicker.date];
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
        self.itemNameField.text = self.syllabusDetails.sectionName;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyy"];
        self.itemDueDateField.text = [dateFormatter stringFromDate:self.syllabusItemDetails.itemDueDate];
    }
  
}
- (void)LabelChange:(id)sender{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.itemDueDateField.text = [dateFormatter stringFromDate:self.datePicker.date];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.itemNameField.delegate = self;
    self.itemDueDateField.delegate = self;

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
    self.itemNameField.inputAccessoryView = keyboardToolbar;
    self.itemDueDateField.inputAccessoryView = keyboardToolbar;
    self.itemDueDateField.inputView = self.datePicker;
}

- (void) doneKey:(id)sender
{
    if ([self.itemNameField isFirstResponder])
        [self.itemNameField resignFirstResponder];
    else if ([self.itemDueDateField isFirstResponder])
        [self.itemDueDateField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([self.itemNameField isFirstResponder])
    {
        [self.itemNameField resignFirstResponder];
        [self.itemDueDateField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[self.itemDueDateField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([self.itemDueDateField isFirstResponder])
    {
        [self.itemDueDateField resignFirstResponder];
        [self.itemNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[self.itemNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([self.itemNameField isFirstResponder])
    {
        [self.itemNameField resignFirstResponder];
        [self.itemDueDateField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[self.itemDueDateField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([self.itemDueDateField isFirstResponder])
    {
        [self.itemDueDateField resignFirstResponder];
        [self.itemNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[self.itemNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setHeaderText:nil];
    [self setItemNameField:nil];
    [self setItemDueDateField:nil];
    [self setItemGradeField:nil];
    [self setItemOutOfField:nil];
    [self setItemIncludeSwitch:nil];
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
    if ([self.itemNameField.text length] == 0)
    {
        NSLog(@"Item Name field is Required.");
        return;
    }
    
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveSyllabusItem:self.itemNameField.text syllabusDetails:self.syllabusDetails context:self.managedObjectContext];
    
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
                NSLog(@"Save Syllabus Item Information");
                self.syllabusItemDetails.itemName = self.itemNameField.text;
                
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                self.syllabusItemDetails.itemDueDate = [dateFormatter dateFromString:self.itemDueDateField.text];

                //self.syllabusItemDetails.itemDueDate = self.itemDueDateField.text;
                //self.syllabusItemDetails.itemScore = self.courseDetails;
                //self.syllabusItemDetails.itemOutOf = self.courseDetails;
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
        NSString *entityName = @"SyllabusItemDetails";
        self.syllabusItemDetails = [NSEntityDescription
                              insertNewObjectForEntityForName:entityName
                              inManagedObjectContext:self.managedObjectContext];
        self.syllabusItemDetails.itemName = self.itemNameField.text;
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        self.syllabusItemDetails.itemDueDate = [dateFormatter dateFromString:self.itemDueDateField.text];

        //self.syllabusItemDetails.itemScore = self.courseDetails;
        //self.syllabusItemDetails.itemOutOf = self.courseDetails;
        self.syllabusItemDetails.syllabusDetails = self.syllabusDetails;
        NSLog(@"About to save data = %@", self.syllabusItemDetails);
        if ([self.managedObjectContext save:&error])
        {
            [self.navigationController popViewControllerAnimated:YES];
            //[self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
        }
        else
        {
            NSLog(@"Add Course Failed! :%@", error.userInfo);
        }
    }
    else
    {
        NSLog(@"Course Code already taken.");
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
