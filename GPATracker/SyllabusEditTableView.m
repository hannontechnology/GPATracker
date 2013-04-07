//
//  SyllabusEditTableView.m
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import "SyllabusEditTableView.h"
#import "CourseDetails.h"
#import "SemesterDetails.h"
#import "SchoolDetails.h"
#import "gradingScheme.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "CourseEditTableView.h"
#import "CustomCellBackground.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SyllabusEditTableView ()
@property (strong, nonatomic) UIPickerView *pickerView;
@property CGRect pickerViewShownFrame;
@property CGRect pickerViewHiddenFrame;
@property (strong, nonatomic) NSMutableArray *sectionList;
@property (strong, nonatomic) NSMutableArray *gradeList;
@property (strong, nonatomic) NSMutableArray *modList;
//@property (strong, nonatomic) SyllabusDetails *syllabusDetails;

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SyllabusEditTableView
@synthesize sectionNameField;
@synthesize sectionActualGradeField;
@synthesize sectionDesiredGradeField;
@synthesize sectionPassFailField;
@synthesize sectionIncludeInGPAField;
@synthesize sectionPercentageField;
@synthesize sectionDescriptionField;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize setGradeType = _setGradeType;

@synthesize pickerView = _pickerView;
@synthesize pickerViewShownFrame = _pickerViewShownFrame;
@synthesize pickerViewHiddenFrame = _pickerViewHiddenFrame;

@synthesize sectionList = _sectionList;
@synthesize gradeList = _gradeList;
@synthesize modList = _modList;

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

-(IBAction)switchPassFail:(id)sender
{
    sectionDesiredGradeField.text = @"";
    sectionActualGradeField.text  = @"";
    if (sectionPassFailField.on)
    {
        self.gradeList = [[NSMutableArray alloc] init];
        [self.gradeList addObject:@""];
        SchoolDetails *tmpSchool = self.semesterDetails.schoolDetails;
        NSArray *tmpGrades = [self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext];
        for (GradingScheme *grade in tmpGrades)
        {
            [self.gradeList addObject:grade.letterGrade];
        }
        //self.gradeList = [[NSMutableArray alloc] initWithArray:[self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext]];
    }
    else
    {
        self.gradeList = [[NSMutableArray alloc] init];
        [self.gradeList addObject:@""];
        SchoolDetails *tmpSchool = self.semesterDetails.schoolDetails;
        NSArray *tmpGrades = [self.dataCollection retrieveGradingScheme:tmpSchool passFail:0 context:self.managedObjectContext];
        for (GradingScheme *grade in tmpGrades)
        {
            [self.gradeList addObject:grade.letterGrade];
        }
        //self.gradeList = [[NSMutableArray alloc] initWithArray:[self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext]];
    }
    [self.pickerView reloadAllComponents];
}

/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    int selComp0;
    
    if (textField == sectionDesiredGradeField)
    {
        self.setGradeType = @"Desired";
    }
    else if (textField == self.sectionActualGradeField)
    {
        self.setGradeType = @"Actual";
    }
    else
    {
        return true;
    }
    NSLog(@"GradeList=%@",self.gradeList);
    if (self.setGradeType == (NSString *)@"Desired")
    {
        if (self.sectionDesiredGradeField.text.length > 0)
        {
            NSString *gradeValue;
            gradeValue = sectionDesiredGradeField.text;
            selComp0 = [self.gradeList indexOfObject:gradeValue];
        }
        else
        {
            selComp0 = 0;
        }
    }
    else if (self.setGradeType == (NSString *)@"Actual")
    {
        if (self.sectionActualGradeField.text.length > 0)
        {
            NSString *gradeValue;
            gradeValue = sectionActualGradeField.text;
            selComp0 = [self.gradeList indexOfObject:gradeValue];
        }
        else
        {
            selComp0 = 0;
        }
    }
    if ([self.gradeList count] > 0)
        [self.pickerView selectRow:selComp0 inComponent:0 animated:YES];
    
    return true;
}*/



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.gradeList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.gradeList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedSection;
    
    selectedSection = [self.sectionList objectAtIndex:[pickerView selectedRowInComponent:0]];
    /*NSString *selectedGrade;
    
    selectedGrade = [self.gradeList objectAtIndex:[pickerView selectedRowInComponent:0]];
    if (self.setGradeType == (NSString *)@"Desired")
    {
        sectionDesiredGradeField.text = selectedGrade;
    }
    else if (self.setGradeType == (NSString *)@"Actual")
    {
        sectionActualGradeField.text = selectedGrade;
    }*/
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
    
    // Set pickerView's shown and hidden position frames.
    self.pickerViewShownFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height - kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    self.pickerViewHiddenFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height + kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    
    // Set up the initial state of the picker.
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = self.pickerViewShownFrame;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    
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
    
    sectionNameField.inputAccessoryView = self.pickerView;
    sectionNameField.inputAccessoryView = keyboardToolbar;
    sectionPercentageField.inputAccessoryView = keyboardToolbar;
    sectionDescriptionField.inputAccessoryView = keyboardToolbar;
    //sectionDesiredGradeField.inputAccessoryView = keyboardToolbar;
    //sectionActualGradeField.inputAccessoryView = keyboardToolbar;
    //sectionDesiredGradeField.inputView = self.pickerView;
    //sectionActualGradeField.inputView = self.pickerView;
        
    //cancelButton.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.hidesBackButton = YES;
    
    self.gradeList = [[NSMutableArray alloc] init];
    if (sectionPassFailField.on)
    {
        self.gradeList = [[NSMutableArray alloc] init];
        [self.gradeList addObject:@""];
        SchoolDetails *tmpSchool = self.semesterDetails.schoolDetails;
        NSArray *tmpGrades = [self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext];
        for (GradingScheme *grade in tmpGrades)
        {
            [self.gradeList addObject:grade.letterGrade];
            NSLog(@"letterGrade = %@", grade.letterGrade);
        }
        //self.gradeList = [[NSMutableArray alloc] initWithArray:[self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext]];
    }
    else
    {
        self.gradeList = [[NSMutableArray alloc] init];
        [self.gradeList addObject:@""];
        SchoolDetails *tmpSchool = self.semesterDetails.schoolDetails;
        NSArray *tmpGrades = [self.dataCollection retrieveGradingScheme:tmpSchool passFail:0 context:self.managedObjectContext];
        for (GradingScheme *grade in tmpGrades)
        {
            [self.gradeList addObject:grade.letterGrade];
            NSLog(@"letterGrade = %@", grade.letterGrade);
        }
        //self.gradeList = [[NSMutableArray alloc] initWithArray:[self.dataCollection retrieveGradingScheme:tmpSchool passFail:1 context:self.managedObjectContext]];
    }
    NSLog(@"%@",self.gradeList);
    [self.pickerView reloadAllComponents];
    
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
        //headerText.title = @"Edit Section";
        //sectionNameField.text = self.syllabusDetails.sectionName;
        
    }
    /*else
    {
        NSLog(@"Load Course Information");
        headerText.title = @"Edit Section";
        sectionNameField.text = self.syllabusDetails.sectionName;
        sectionPercentageField.text = self.syllabusDetails.stringValue;
        
        sectionDesiredGradeField.text = self.courseDetails.desiredGradeGPA.letterGrade;
        sectionActualGradeField.text  = self.courseDetails.actualGradeGPA.letterGrade;
        if (self.syllabusDetails.isPassFail == [NSNumber numberWithInt:1])
        {
            sectionPassFailField.on = YES;
        }
        else
        {
            sectionPassFailField.on = NO;
        }
        if (self.syllabusDetails.includeInGPA == [NSNumber numberWithInt:1])
        {
            sectionIncludeInGPAField.on = YES;
        }
        else
        {
            sectionIncludeInGPAField.on = NO;
        }
    }*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.sectionActualGradeField.delegate = self;
    //self.sectionDesiredGradeField.delegate = self;
    self.sectionNameField.delegate = self;
    self.sectionPercentageField.delegate = self;
    self.sectionDescriptionField.delegate = self;
    
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
       
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) doneKey:(id)sender
{
    if ([sectionNameField isFirstResponder])
        [sectionNameField resignFirstResponder];
    //else if ([sectionDesiredGradeField isFirstResponder])
      //  [sectionDesiredGradeField resignFirstResponder];
    //else if ([sectionActualGradeField isFirstResponder])
      //  [sectionActualGradeField resignFirstResponder];
    else if ([sectionPercentageField isFirstResponder])
        [sectionPercentageField resignFirstResponder];
    else if ([sectionDescriptionField isFirstResponder])
        [sectionDescriptionField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([sectionDescriptionField isFirstResponder])
    {
        [sectionDescriptionField resignFirstResponder];
        [sectionPercentageField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionPercentageField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionNameField isFirstResponder])
    {
        [sectionNameField resignFirstResponder];
        [sectionDescriptionField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionDescriptionField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionPercentageField isFirstResponder])
    {
        [sectionPercentageField resignFirstResponder];
        [sectionActualGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    /*else if ([sectionActualGradeField isFirstResponder])
    {
        [sectionActualGradeField resignFirstResponder];
        [sectionDesiredGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionDesiredGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionDesiredGradeField isFirstResponder])
    {
     [sectionDesiredGradeField resignFirstResponder];
     [sectionNameField becomeFirstResponder];
     UITableViewCell *cell = (UITableViewCell*) [[sectionNameField superview] superview];
     [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }*/
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([sectionDescriptionField isFirstResponder])
    {
        [sectionDescriptionField resignFirstResponder];
        [sectionNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionNameField isFirstResponder])
    {
        [sectionNameField resignFirstResponder];
        [sectionDesiredGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionPercentageField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    /*else if ([sectionDesiredGradeField isFirstResponder])
    {
        [sectionDesiredGradeField resignFirstResponder];
        [sectionActualGradeField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionActualGradeField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([sectionActualGradeField isFirstResponder])
    {
        [sectionActualGradeField resignFirstResponder];
        [sectionPercentageField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionPercentageField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }*/
    else if ([sectionPercentageField isFirstResponder])
    {
        [sectionPercentageField resignFirstResponder];
        [sectionDescriptionField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[sectionDescriptionField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setHeaderText:nil];
    [self setPickerView:nil];
    [self setSectionNameField:nil];
    [self setSectionDesiredGradeField:nil];
    [self setSectionDesiredGradeField:nil];
    [self setSectionActualGradeField:nil];
    [self setSectionPassFailField:nil];
    [self setSectionIncludeInGPAField:nil];
    [self setSectionPercentageField:nil];
    [self setSectionDescriptionField:nil];
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
    NSNumber *includeInGPA = [NSNumber numberWithBool:NO];
    NSNumber *isPassFail = [NSNumber numberWithBool:NO];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *s_units;
    
    if (sectionPassFailField.on)
    {
        isPassFail = [NSNumber numberWithBool:YES];
    }
    if (sectionIncludeInGPAField.on)
    {
        includeInGPA = [NSNumber numberWithBool:YES];
    }
    if ([sectionNameField.text length] == 0)
    {
        NSLog(@"Section Name field is Required.");
        return;
    }
    if ([sectionDescriptionField.text length] == 0)
    {
        NSLog(@"Section Description field is Required.");
        return;
    }
    if ([sectionPercentageField.text length] == 0)
    {
        NSLog(@"Course Units field is Required.");
        return;
    }
    
    //NSError *error = nil;
    /* //NSArray *results = [self.dataCollection retrieveCourse:sylla.text semesterDetails:self.semesterDetails context:self.managedObjectContext];
    
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
    }*/
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
