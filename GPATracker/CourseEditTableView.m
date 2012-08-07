//
//  CourseEditTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseEditTableView.h"
#import "CourseDetails.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "LoginView.h"
#import "CourseTableView.h"


@interface CourseEditTableView ()

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
        courseDesiredGradeField.text = self.courseDetails.desiredGrade;
        courseActualGradeField.text  = self.courseDetails.actualGrade;
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
                self.courseDetails.desiredGrade = courseDesiredGradeField.text;
                self.courseDetails.actualGrade  = courseActualGradeField.text;
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
        self.courseDetails.desiredGrade = courseDesiredGradeField.text;
        self.courseDetails.actualGrade  = courseActualGradeField.text;
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
