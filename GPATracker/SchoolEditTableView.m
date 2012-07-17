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
#import "HomePageTableView.h"

@class DataCollection;
@class SchoolDetails;
//@class GradingScheme;

@interface SchoolEditTableView ()
- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SchoolEditTableView
@synthesize schoolNameField;
@synthesize userName;
@synthesize schoolDetailsField;
@synthesize schoolStartYearField;
@synthesize schoolEndYearField;
@synthesize setStatus;
@synthesize headerText;

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
    
    if (self.setStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:userName];
    
    if (results == nil)
    {
        //status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Load School Page");
            headerText.title = @"Edit School";
            for (SchoolDetails *item in results)
            {
                schoolNameField.text  = item.schoolName;
                schoolDetailsField.text = item.schoolDetails;
                schoolStartYearField.text = item.schoolStartYear;
                schoolEndYearField.text = item.schoolEndYear;
            }
        }
    }

}

- (IBAction)Save:(id)sender{
    if ([schoolNameField.text length] == 0) {
        //setStatus.text = @"School Name field is required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    NSArray *results = [data retrieveSchools:schoolNameField.text userName:(NSString *)userName];
    if (setStatus == @"Edit")
    {
        if ([schoolNameField.text length] == 0)
        {
            //status.text = @"School name field is Required.";
        }
        else if ([schoolStartYearField.text length] == 0)
        {
            //status.text = @"School start year field is Required.";
        }
        else 
        {
            schoolNameField = schoolNameField.text;
            DataCollection *data = [[DataCollection alloc]init];
            NSArray *results = [data retrieveSchools:schoolNameField userName:(NSString *)userName];
            if (results == nil)
            {
                status.text = @"Database Error: Could not connect to Database.";
            }
            else
            {
                if ([results count] > 0)
                {
                    NSLog(@"Save School Page");
                    for (SchoolDetails *item in results)
                    {
                        item.schoolName = schoolNameField.text;
                        item.schoolDetails = schoolDetailsField.text;
                        item.schoolStartYear = schoolStartYearField.text;
                        item.schoolEndYear = schoolEndYearField.text;
                        //item.schoolCalculatedGPA = calculatedGPAField.text;
                        item.userName = userName;
                    }
                    if ([data updateSchool:results] == 0)
                    {
                        [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                    }
                    else
                    {
                        // do nothing
                    }
                }
            }
        }
        
    }
    else if ([results count] == 0)
    {
        if ([schoolNameField.text length] == 0)
        {
            status.text = @"School Name field is Required.";
        }
        else if ([schoolStartYearField.text length] == 0) {
            status.text = @"School start year field is Required.";
        }
        else
        {
            int addResult = [data addSchool:(NSString *)schoolNameField.text schoolDetail:(NSString *)schoolDetailsField.text schoolStartYear:(NSString *)schoolStartYearField.text schoolEndYear:(NSString *)schoolEndYearField.text userName:(NSString *)userName];
            if (addResult == 0)
            {
                if (getData == @"Edit")
                {
                    schoolName = schoolNameField.text;
                    [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
                else
                {
                    schoolName = schoolNameField.text;
                    [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
            }   
            else
            {
                status.text = @"Create school failed.";
            }
        }
    }
    else
    {
        status.text = @"School Name already taken.";
    }    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gradingScheme:(UIButton *)sender{
    
}

- (IBAction)Cancel:(id)sender
{
    if (setStatus == @"Edit")
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
        UINavigationController *navCon = [segue destinationViewController];
        SchoolEditTableView *SchoolEditTableView = [navCon.viewControllers objectAtIndex:0];
        SchoolEditTableView.userName = userName;
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
    
} @end
