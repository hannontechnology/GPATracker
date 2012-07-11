//
//  CreateSchoolView.m
//  GPATracker
//
//  Created by David Stevens on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolEditView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "HomePageTableView.h"
#import "SelectGradingSchemeView.h"

@interface SchoolEditView ()

@end

@implementation SchoolEditView
@synthesize school = _school;
@synthesize dataCollection = _dataCollection;
@synthesize schoolName;
@synthesize schoolNameField;
@synthesize schoolDetailsField;
@synthesize schoolStartYearField;
@synthesize schoolEndYearField;
@synthesize calculatedGPAField;
@synthesize actualGPAField;
@synthesize getData;
@synthesize userName;
@synthesize status;
@synthesize headerText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.getData != @"Edit")
    {
        return;
    }
    
    DataCollection *data = [[DataCollection alloc] init];
    NSArray *results = [data retrieveSchools:schoolName userName:(NSString *)userName];
    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database.";
    }
    else if ([results count] > 0)
    {
        NSLog(@"Load School Edit Page");
        headerText.title = @"Edit School";
        for (SchoolDetails *item in results)
        {
            schoolNameField.text = item.schoolName;
            schoolDetailsField.text = item.schoolDetails;
            schoolStartYearField.text = item.schoolStartYear;
            schoolEndYearField.text = item.schoolEndYear;
            //calculatedGPAField.text = item.schoolCalculatedGPA;
            //actualGPAField.text = item.schoolActualGPA;
        }
        
    }
}

- (void)viewDidUnload
{
    [self setSchoolNameField:nil];
    [self setSchoolDetailsField:nil];
    [self setSchoolStartYearField:nil];
    [self setSchoolEndYearField:nil];
    [self setCalculatedGPAField:nil];
    [self setActualGPAField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)EditGradingScheme:(id)sender {
    if ([schoolNameField.text length] == 0) {
        status.text = @"School Name field is required.";
        return;
    }
    //DataCollection *data = [DataCollection alloc];
    else {
        [self performSegueWithIdentifier:@"SelectGradingSchemeSegue" sender:self];
    }
    
}

- (IBAction)Accept:(UIBarButtonItem *)sender {
    if ([schoolNameField.text length] == 0) {
        status.text = @"School Name field is required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    NSArray *results = [data retrieveSchools:schoolNameField.text userName:(NSString *)userName];
    if (getData == @"Edit")
    {
        if ([schoolNameField.text length] == 0)
        {
            status.text = @"School name field is Required.";
        }
        else if ([schoolStartYearField.text length] == 0)
        {
            status.text = @"School start year field is Required.";
        }
        else 
        {
            schoolName = schoolNameField.text;
            DataCollection *data = [[DataCollection alloc]init];
            NSArray *results = [data retrieveSchools:schoolName userName:(NSString *)userName];
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
                        //item.schoolActualGPA = actualGPAField.text;
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
    

- (IBAction)Cancel:(id)sender
{
    if (getData == @"Edit")
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
        HomePageTableView *HomePageTableView = [navCon.viewControllers objectAtIndex:0];
        
        HomePageTableView.userName = userName;
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 
@end
