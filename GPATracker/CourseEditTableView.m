//
//  CourseEditTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseEditTableView.h"
#import "Course.h"
#import "DataCollection.h"
#import "HomePageTableView.h"
#import "LoginView.h"


@interface CourseEditTableView ()

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation CourseEditTableView
@synthesize setEditStatus = _setEditStatus;
@synthesize userName = _userName;
@synthesize courseCodeField;
@synthesize courseNameField;
@synthesize courseUnitsField;
@synthesize courseDesiredGradeField;
@synthesize courseActualGradeField;
@synthesize coursePassFailField;
@synthesize courseIncludeInGPAField;
@synthesize courseDescriptionField;
@synthesize headerText;

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
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:self.userName];
    
    if (results == nil)
    {
        //status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Load Profile Page");
            headerText.title = @"Edit Profile";
            for (Course *item in results)
            {
                courseCodeField.text  = item.courseCode;
                courseNameField.text  = item.courseName;
                //courseUnitsField.text  = item.units;
                //courseDesiredGradeField.text = item.desiredGrade;
                //courseActualGradeField.text  = item.actualGrade;
                if (item.isPassFail == [NSNumber numberWithInt:1])
                {
                    coursePassFailField.on = YES;
                }
                if (item.includeInGPA == [NSNumber numberWithInt:1])
                {
                    courseIncludeInGPAField.on = YES;
                }
            }
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
    if ([courseCodeField.text length] == 0)
    {
        //status.text = @"Username field is Required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:courseCodeField.text];
    NSNumber *includeInGPA = 0;
    NSNumber *isPassFail = 0;
    
    if (self.setEditStatus == @"Edit")
    {
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
            //status.text = @"Password field is Required.";
        }
        else
        {
            self.courseCode = courseCodeField.text;
            DataCollection *data = [[DataCollection alloc] init];
            
            //NSError *error = nil;
            NSArray *results = [data retrieveUsers:self.userName];
            
            if (results == nil)
            {
                //status.text = @"Database Error: Could not connect to Database";
            }
            else
            {
                if ([results count] > 0)
                {
                    NSLog(@"Save Profile Page");
                    for (Course *item in results)
                    {
                        item.courseCode   = courseCodeField.text;
                        item.courseName   = courseNameField.text;
                        //item.units        = courseUnitsField.text;
                        //item.desiredGrade = courseDesiredGradeField.text;
                        //item.actualGrade  = courseActualGradeField.text;
                        item.isPassFail   = isPassFail;
                        item.includeInGPA = includeInGPA;
                        item.courseDesc   = courseDescriptionField.text;
                    }
                    if ([data updateUser:results] == 0)
                    {
                        [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
                    }
                    else 
                    {
                    }
                }
            }
        }      
    }
    else if ([results count] == 0)
    {
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
            //status.text = @"Password field is Required.";
        }
        else
        {
            //int addResult = [data addUser:(NSString *)userNameField.text userPassword:(NSString *)passwordField.text userFirstName:(NSString *)firstNameField.text userLastName:(NSString *)lastNameField.text userEmail:(NSString *)emailField.text autoLogin:(NSNumber *)autoLogin];
            //if (addResult == 0)
            //{
            //    self.userName = userNameField.text;
            //    [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
            //}
            //else 
            //{
                //status.text = @"Create user failed!";
            //}
        }
    }
    else
    {
        //status.text = @"Username already taken.";
    }    
}

- (IBAction)Cancel:(id)sender
{
    if (self.setEditStatus == @"Edit")
    {
        [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
    }
    else
    {
        [self performSegueWithIdentifier: @"segueProfile2Login" sender: self];
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueProfile2HomePage"])
	{
        //        UINavigationController *navCon = [segue destinationViewController];
        //        HomePageTableView *HomePageTableView = [navCon.viewControllers objectAtIndex:0];
        HomePageTableView *HomePageTableView = [segue destinationViewController];
        
        HomePageTableView.userName = self.userName;
	}
	else if ([segue.identifier isEqualToString:@"segueProfile2Login"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.getData  = @"Logout";
        LoginView.userName = self.userName;
	}
}
@end
