//
//  SchoolEditTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolEditTableView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "User+Create.h"
#import "GradingSchemeSelectTableView.h"

@interface SchoolEditTableView ()
- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SchoolEditTableView
@synthesize schoolNameField;
@synthesize schoolDetailsField;
@synthesize schoolStartYearField;
@synthesize schoolEndYearField;
@synthesize headerText;

@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize userInfo = _userInfo;
@synthesize schoolInfo = _schoolInfo;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setSchoolNameField:nil];
    [self setSchoolDetailsField:nil];
    [self setSchoolStartYearField:nil];
    [self setSchoolEndYearField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //cancelButton.
    
    NSLog(@"viewWillAppear Event of SchoolEditTableView");
    
    if (self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    if (self.schoolInfo == nil)
    {
        NSLog(@"Database Error: Could not connect to Database");
    }
    else
    {
        NSLog(@"Load School Page");
        headerText.title = @"Edit School";
        schoolNameField.text  = self.schoolInfo.schoolName;
        schoolDetailsField.text = self.schoolInfo.schoolDetails;
        schoolStartYearField.text = self.schoolInfo.schoolStartYear;
        schoolEndYearField.text = self.schoolInfo.schoolEndYear;
    }

}

- (IBAction)Save:(id)sender{
    if ([schoolNameField.text length] == 0)
    {
        NSLog(@"School name field is Required.");
        return;
    }
    else if ([schoolStartYearField.text length] == 0)
    {
        NSLog(@"School start year field is Required.");
        return;
    }
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveSchools:schoolNameField.text user:(User *)self.userInfo context:(NSManagedObjectContext *)self.managedObjectContext];

    if (self.setEditStatus == @"Edit")
    {
        if (self.schoolInfo == nil)
        {
            NSLog(@"Database Error: Could not connect to Database.");
        }
        else
        {
            NSLog(@"Save School Page");
            self.schoolInfo.schoolName = schoolNameField.text;
            self.schoolInfo.schoolDetails = schoolDetailsField.text;
            self.schoolInfo.schoolStartYear = schoolStartYearField.text;
            self.schoolInfo.schoolEndYear = schoolEndYearField.text;
            if ([[self managedObjectContext] save:&error])
            {
                NSLog(@"Save was successful");
                [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
            }
            else
            {
                NSLog(@"Save Failed!");
            }
        }
        
    }
    else if ([results count] == 0)
    {
        NSString *entityName = @"SchoolDetails";
        self.schoolInfo = [NSEntityDescription
                         insertNewObjectForEntityForName:entityName
                         inManagedObjectContext:self.managedObjectContext];
        self.schoolInfo.user            = self.userInfo;
        self.schoolInfo.schoolName      = schoolNameField.text;
        self.schoolInfo.schoolDetails   = schoolDetailsField.text;
        self.schoolInfo.schoolStartYear = schoolStartYearField.text;
        self.schoolInfo.schoolEndYear   = schoolEndYearField.text;
        
        NSDecimalNumber *temp3 = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        NSDecimalNumber *temp4 = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        
        self.schoolInfo.schoolActualGPA = temp3;
        self.schoolInfo.schoolCalculatedGPA = temp4;
        
        if ([self.managedObjectContext save:&error])
        {
            if (self.setEditStatus == @"Edit")
            {
                [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
            }
        }
        else 
        {
            NSLog(@"Create school failed!");
        }
    }
    else
    {
        NSLog(@"School Name already taken!");
    } 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gradingScheme:(UIButton *)sender{
    if (self.setEditStatus != @"Edit")
    {
       //Control visiability of button later
    }
}

- (IBAction)Cancel:(id)sender
{
    if (self.setEditStatus == @"Edit")
    {
        [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueSchool2HomePage"])
    {
        SchoolListTableView *SchoolListTableView = [segue destinationViewController];
        
        SchoolListTableView.userInfo = self.userInfo;
        SchoolListTableView.dataCollection = self.dataCollection;
        SchoolListTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueSchool2SchemeSelect"])
    {
        GradingSchemeSelectTableView *GradingSchemeSelectTableView = [segue destinationViewController];
        
        GradingSchemeSelectTableView.userInfo = self.userInfo;
        GradingSchemeSelectTableView.dataCollection = self.dataCollection;
        GradingSchemeSelectTableView.managedObjectContext = self.managedObjectContext;
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
    
} @end
