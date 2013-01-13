//
//  CourseEditTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseEditTableView.h"
#import "CourseDetails.h"
#import "GradingScheme+Create.h"
#import "SemesterDetails+Create.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "LoginView.h"
#import "CourseTableView.h"

// PickerDismissView's only job is to partially occlude the rest of the view when the picker appears and to catch touches to dismiss the picker.
@interface PickerDismissView : UIView
@property (nonatomic, strong) id parentViewController;
@end

@implementation PickerDismissView
@synthesize parentViewController = _parentViewController;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Got a touch? Tell parentViewController to dismiss the picker.
    [self.parentViewController performSelector:@selector(dismissPickerView)];
}
@end

@interface CourseEditTableView ()
@property (strong, nonatomic) PickerDismissView *pickerDismissView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property CGRect pickerDismissViewShownFrame;
@property CGRect pickerDismissViewHiddenFrame;
@property CGRect pickerViewShownFrame;
@property CGRect pickerViewHiddenFrame;
@property (strong, nonatomic) NSMutableArray *gradeList;
@property (strong, nonatomic) NSMutableArray *modList;

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation CourseEditTableView
@synthesize courseCodeField;
@synthesize courseNameField;
@synthesize courseUnitsField;
@synthesize courseDesiredGradeField;
@synthesize courseActualGradeField;
@synthesize coursePassFailField;
@synthesize courseIncludeInGPAField;
@synthesize courseDescriptionField;
@synthesize headerText;

@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize semesterDetails = _semesterDetails;
@synthesize courseDetails = _courseDetails;
@synthesize setGradeType = _setGradeType;

@synthesize pickerView = _pickerView;
@synthesize pickerViewShownFrame = _pickerViewShownFrame;
@synthesize pickerViewHiddenFrame = _pickerViewHiddenFrame;

@synthesize gradeList = _gradeList;
@synthesize modList = _modList;

// Some values that will be handy later on.
static const CGFloat kPickerDefaultWidth = 320.f;
static const CGFloat kPickerDefaultHeight = 216.f;
static const CGFloat kPickerDismissViewShownOpacity = 0.333;
static const CGFloat kPickerDismissViewHiddenOpacity = 0.f;
static const NSTimeInterval kPickerAnimationTime = 0.333;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.gradeList count];
    }
    else if (component == 1)
    {
        return [self.modList count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.gradeList objectAtIndex:row];
    }
    else if (component == 1)
    {
        return [self.modList objectAtIndex:row];
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedGrade;
    
    selectedGrade = [NSString stringWithFormat:@"%@%@", [self.gradeList objectAtIndex:[pickerView selectedRowInComponent:0]], [self.modList objectAtIndex:[pickerView selectedRowInComponent:1]]];
    if (self.setGradeType == @"Desired")
    {
        courseDesiredGradeField.text = selectedGrade;
    }
    else if (self.setGradeType == @"Actual")
    {
        courseActualGradeField.text = selectedGrade;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.gradeList = [[NSMutableArray alloc] init];
    [self.gradeList addObject:@""];
    [self.gradeList addObject:@"A"];
    [self.gradeList addObject:@"B"];
    [self.gradeList addObject:@"C"];
    [self.gradeList addObject:@"D"];
    [self.gradeList addObject:@"E"];
    [self.gradeList addObject:@"F"];

    self.modList = [[NSMutableArray alloc] init];
    [self.modList addObject:@""];
    [self.modList addObject:@"+"];
    [self.modList addObject:@"-"];

    // Set pickerView's shown and hidden position frames.
    self.pickerViewShownFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height - kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    self.pickerViewHiddenFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height + kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    // Set picker dismiss view's shown and hidden position frames.
    self.pickerDismissViewShownFrame = CGRectMake(0.f, 0.f, kPickerDefaultWidth, self.navigationController.view.frame.size.height - kPickerDefaultHeight);
    self.pickerDismissViewHiddenFrame = self.navigationController.view.frame;
    
    // Set up the initial state of the picker.
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = self.pickerViewHiddenFrame;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;

    //cancelButton.
    if (self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }

    if (self.courseDetails == nil)
    {
        NSLog(@"Database Error: Could not connect to Database");
    }
    else
    {
        NSLog(@"Load Course Information");
        headerText.title = @"Edit Course";
        courseCodeField.text  = self.courseDetails.courseCode;
        courseNameField.text  = self.courseDetails.courseName;
        courseUnitsField.text  = self.courseDetails.units.stringValue;
        courseDesiredGradeField.text = self.courseDetails.desiredGradeGPA.letterGrade;
        courseActualGradeField.text  = self.courseDetails.actualGradeGPA.letterGrade;
        if (self.courseDetails.isPassFail == [NSNumber numberWithInt:1])
        {
            coursePassFailField.on = YES;
        }
        if (self.courseDetails.includeInGPA == [NSNumber numberWithInt:1])
        {
            courseIncludeInGPAField.on = YES;
        }
    }
    
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

    courseCodeField.inputAccessoryView = keyboardToolbar;
    courseNameField.inputAccessoryView = keyboardToolbar;
    courseUnitsField.inputAccessoryView = keyboardToolbar;
    courseDesiredGradeField.inputView = self.pickerView;
    courseDesiredGradeField.inputAccessoryView = keyboardToolbar;
    courseActualGradeField.inputView = self.pickerView;
    courseActualGradeField.inputAccessoryView = keyboardToolbar;
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
    courseCodeField.inputAccessoryView = keyboardToolbar;
    courseNameField.inputAccessoryView = keyboardToolbar;
    courseUnitsField.inputAccessoryView = keyboardToolbar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) doneKey:(id)sender
{
    if ([courseCodeField isFirstResponder])
        [courseCodeField resignFirstResponder];
    else if ([courseNameField isFirstResponder])
        [courseNameField resignFirstResponder];
    else if ([courseUnitsField isFirstResponder])
        [courseUnitsField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([courseCodeField isFirstResponder])
    {
        [courseCodeField resignFirstResponder];
        [courseActualGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseActualGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseNameField isFirstResponder])
    {
        [courseNameField resignFirstResponder];
        [courseCodeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseCodeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseUnitsField isFirstResponder])
    {
        [courseUnitsField resignFirstResponder];
        [courseNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseDesiredGradeField isFirstResponder])
    {
        [courseDesiredGradeField resignFirstResponder];
        [courseUnitsField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseUnitsField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseActualGradeField isFirstResponder])
    {
        [courseActualGradeField resignFirstResponder];
        [courseDesiredGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseDesiredGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([courseCodeField isFirstResponder])
    {
        [courseCodeField resignFirstResponder];
        [courseNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseNameField isFirstResponder])
    {
        [courseNameField resignFirstResponder];
        [courseUnitsField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseUnitsField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseUnitsField isFirstResponder])
    {
        [courseUnitsField resignFirstResponder];
        [courseDesiredGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseDesiredGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseDesiredGradeField isFirstResponder])
    {
        [courseDesiredGradeField resignFirstResponder];
        [courseActualGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseActualGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([courseActualGradeField isFirstResponder])
    {
        [courseActualGradeField resignFirstResponder];
        [courseCodeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[courseCodeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setCourseCodeField:nil];
    [self setCourseNameField:nil];
    [self setCourseUnitsField:nil];
    [self setCourseDesiredGradeField:nil];
    [self setCourseActualGradeField:nil];
    [self setCoursePassFailField:nil];
    [self setCourseIncludeInGPAField:nil];
    [self setCourseDescriptionField:nil];
    [self setHeaderText:nil];
    [self setPickerView:nil];
    [self setPickerDismissView:nil];
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
    NSNumber *includeInGPA = [NSNumber numberWithInt:0];
    NSNumber *isPassFail = [NSNumber numberWithInt:0];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *s_units;
    
    if (coursePassFailField.on)
    {
        isPassFail = [NSNumber numberWithInt:1];
    }
    if (courseIncludeInGPAField.on)
    {
        includeInGPA = [NSNumber numberWithInt:1];
    }
    if ([courseNameField.text length] == 0)
    {
        NSLog(@"Course Name field is Required.");
        return;
    }
    if ([courseCodeField.text length] == 0)
    {
        NSLog(@"Course Code field is Required.");
        return;
    }
    if ([courseUnitsField.text length] == 0)
    {
        NSLog(@"Course Units field is Required.");
        return;
    }
    else
    {
        s_units = [f numberFromString:courseUnitsField.text];
    }
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveCourse:courseCodeField.text semesterDetails:self.semesterDetails context:self.managedObjectContext];
    
    if (self.setEditStatus == @"Edit")
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
                self.courseDetails.courseCode   = courseCodeField.text;
                self.courseDetails.courseName   = courseNameField.text;
                self.courseDetails.units        = s_units;
                if (courseDesiredGradeField.text == nil || courseDesiredGradeField.text == nil)
                {
                    self.courseDetails.desiredGradeGPA = nil;
                }
                else
                {
                    self.courseDetails.desiredGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseDesiredGradeField.text context:self.managedObjectContext];
                }
                if (courseActualGradeField.text == nil || courseActualGradeField.text == nil)
                {
                    self.courseDetails.actualGradeGPA = nil;
                }
                else
                {
                    self.courseDetails.actualGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseActualGradeField.text context:self.managedObjectContext];
                }
                self.courseDetails.isPassFail   = isPassFail;
                self.courseDetails.includeInGPA = includeInGPA;
                self.courseDetails.courseDesc   = courseDescriptionField.text;
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
        NSString *entityName = @"CourseDetails";
        self.courseDetails = [NSEntityDescription
                                insertNewObjectForEntityForName:entityName
                                inManagedObjectContext:self.managedObjectContext];
        self.courseDetails.semesterDetails = self.semesterDetails;
        self.courseDetails.courseCode   = courseCodeField.text;
        self.courseDetails.courseName   = courseNameField.text;
        self.courseDetails.units        = s_units;
        if (courseDesiredGradeField.text == nil || courseDesiredGradeField.text == nil)
        {
            self.courseDetails.desiredGradeGPA = nil;
        }
        else
        {
            self.courseDetails.desiredGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseDesiredGradeField.text context:self.managedObjectContext];
        }
        if (courseActualGradeField.text == nil || courseActualGradeField.text == nil)
        {
            self.courseDetails.actualGradeGPA = nil;
        }
        else
        {
            self.courseDetails.actualGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseActualGradeField.text context:self.managedObjectContext];
        }
        self.courseDetails.isPassFail   = isPassFail;
        self.courseDetails.includeInGPA = includeInGPA;
        self.courseDetails.courseDesc   = courseDescriptionField.text;
        NSLog(@"About to save data = %@", self.courseDetails);
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
    if (self.setEditStatus == @"Edit")
    {
        [self.navigationController popViewControllerAnimated:YES];
        //[self performSegueWithIdentifier:@"segueCourse2CourseList" sender:self];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        //[self performSegueWithIdentifier:@"segueCourse2CourseList" sender:self];
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueCourse2CourseList"])
	{
        //[self.navigationController popViewControllerAnimated:YES];
        CourseTableView *CourseTableView = [segue destinationViewController];
        CourseTableView.semesterInfo = self.semesterDetails;
        CourseTableView.dataCollection = self.dataCollection;
        CourseTableView.managedObjectContext = self.managedObjectContext;
	}
}
@end
