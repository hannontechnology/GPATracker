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

@synthesize pickerDismissView = _pickerDismissView;
@synthesize pickerView = _pickerView;
@synthesize pickerDismissViewShownFrame = _pickerDismissViewShownFrame;
@synthesize pickerDismissViewHiddenFrame = _pickerDismissViewHiddenFrame;
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

- (void)showPickerView
{
    // To show the picker, we animate the frame and alpha values for the pickerview and the picker dismiss view.
    [UIView animateWithDuration:kPickerAnimationTime animations:^{
        self.pickerDismissView.frame = self.pickerDismissViewShownFrame;
        self.pickerDismissView.alpha = kPickerDismissViewShownOpacity;
        self.pickerView.frame = self.pickerViewShownFrame;
    }];
    
    int selComp0;
    int selComp1;
    
    if (self.setGradeType == @"Desired")
    {
        NSString *gradeValue;
        NSString *modValue;
        if (courseDesiredGradeField.text.length > 0)
        {
            gradeValue = [courseDesiredGradeField.text substringWithRange:NSMakeRange(0, 1)];
            selComp0 = [self.gradeList indexOfObject:gradeValue];
        }
        else
        {
            selComp0 = 0;
        }
        if (courseDesiredGradeField.text.length > 1)
        {
            modValue = [courseDesiredGradeField.text substringWithRange:NSMakeRange(1, 1)];
            selComp1 = [self.modList indexOfObject:modValue];
        }
        else
        {
            selComp1 = 0;
        }
    }
    else if (self.setGradeType == @"Actual")
    {
        NSString *gradeValue;
        NSString *modValue;
        if (courseActualGradeField.text.length > 0)
        {
            gradeValue = [courseActualGradeField.text substringWithRange:NSMakeRange(0, 1)];
            selComp0 = [self.gradeList indexOfObject:gradeValue];
        }
        else
        {
            selComp0 = 0;
        }
        if (courseActualGradeField.text.length > 1)
        {
            modValue = [courseActualGradeField.text substringWithRange:NSMakeRange(1, 1)];
            selComp1 = [self.modList indexOfObject:modValue];
        }
        else
        {
            selComp1 = 0;
        }
    }
    [self.pickerView selectRow:selComp0 inComponent:0 animated:YES];
    [self.pickerView selectRow:selComp1 inComponent:1 animated:YES];
}

- (void)dismissPickerView
{
    // Ditto to dismiss.
    [UIView animateWithDuration:kPickerAnimationTime animations:^{
        self.pickerDismissView.frame = self.pickerDismissViewHiddenFrame;
        self.pickerDismissView.alpha = kPickerDismissViewHiddenOpacity;
        self.pickerView.frame = self.pickerViewHiddenFrame;
    }];
}

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

-(IBAction)showDesiredGradePicker:(id)sender
{
    self.setGradeType = @"Desired";
    [self showPickerView];
}

-(IBAction)showActualGradePicker:(id)sender
{
    self.setGradeType = @"Actual";
    [self showPickerView];
}

-(IBAction)desiredGradeChange:(id)sender
{
    NSString *desiredGrade;
    courseDesiredGradeField.text = desiredGrade;
}

-(IBAction)actualGradeChange:(id)sender
{
    NSString *actualGrade;
    courseActualGradeField.text = actualGrade;
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
    
    // Add it as a subview of our view.
    [self.navigationController.view insertSubview:self.pickerView aboveSubview:self.navigationController.navigationBar];

    if (!self.pickerDismissView) {
        // Set up the initial state of the picker dismiss view.
        self.pickerDismissView = [[PickerDismissView alloc] init];
        self.pickerDismissView.frame = self.pickerDismissViewHiddenFrame;
        self.pickerDismissView.parentViewController = self;
        self.pickerDismissView.backgroundColor = [UIColor blackColor];
        self.pickerDismissView.alpha = kPickerDismissViewHiddenOpacity;
        
        // We are inserting it as a subview of the navigation controller's view. We do this so that we can make it appear OVER the navigation bar.
        [self.navigationController.view insertSubview:self.pickerDismissView aboveSubview:self.navigationController.navigationBar];
    }

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
        NSLog(@"Load Profile Page");
        headerText.title = @"Edit Profile";
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
                NSLog(@"Save Profile Page");
                self.courseDetails.courseCode   = courseCodeField.text;
                self.courseDetails.courseName   = courseNameField.text;
                self.courseDetails.units        = s_units;
                //self.courseDetails.desiredGrade = courseDesiredGradeField.text;
                //self.courseDetails.actualGrade  = courseActualGradeField.text;
                self.courseDetails.desiredGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseDesiredGradeField.text context:self.managedObjectContext];
                self.courseDetails.actualGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseActualGradeField.text context:self.managedObjectContext];
                self.courseDetails.isPassFail   = isPassFail;
                self.courseDetails.includeInGPA = includeInGPA;
                self.courseDetails.courseDesc   = courseDescriptionField.text;
                if ([self.managedObjectContext save:&error])
                {
                    [self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
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
        //self.courseDetails.desiredGrade = courseDesiredGradeField.text;
        //self.courseDetails.actualGrade  = courseActualGradeField.text;
        self.courseDetails.desiredGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseDesiredGradeField.text context:self.managedObjectContext];
        self.courseDetails.actualGradeGPA = [self.dataCollection retrieveGradingScheme:self.semesterDetails.schoolDetails letterGrade:courseActualGradeField.text context:self.managedObjectContext];
        self.courseDetails.isPassFail   = isPassFail;
        self.courseDetails.includeInGPA = includeInGPA;
        self.courseDetails.courseDesc   = courseDescriptionField.text;
        if ([self.managedObjectContext save:&error])
        {
            [self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
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
    [self performSegueWithIdentifier: @"segueCourse2CourseList" sender: self];
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueCourse2CourseList"])
	{
        [self.navigationController popViewControllerAnimated:YES];
        CourseTableView *CourseTableView = [segue destinationViewController];
        CourseTableView.semesterInfo = self.semesterDetails;
        CourseTableView.dataCollection = self.dataCollection;
        CourseTableView.managedObjectContext = self.managedObjectContext;
	}
}
@end
