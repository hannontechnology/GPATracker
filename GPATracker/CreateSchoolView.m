//
//  CreateSchoolView.m
//  GPATracker
//
//  Created by David Stevens on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateSchoolView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "HomePageView.h"
#import "SelectGradingSchemeView.h"

@interface CreateSchoolView ()

@end

@implementation CreateSchoolView
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.getData != @"Edit") {
        return;
    }
    
    DataCollection *data = [[DataCollection alloc] init];
    NSArray *results = [data retrieveSchools:schoolName];
    if (results == nil) {
        status.text = @"Database Error: Could not connect to Database.";
    }
    else if ([results count] > 0) {
        NSLog(@"Load School Edit Page");
        headerText.title = @"Edit School";
        for (SchoolDetails *item in results) {
            schoolNameField.text = item.schoolName;
            schoolDetailsField.text = item.schoolDetails;
            schoolStartYearField.text = item.schoolStartYear;
            schoolEndYearField.text = item.schoolEndYear;
            calculatedGPAField.text = item.schoolCalculatedGPA;
            actualGPAField.text = item.schoolActualGPA;
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
    
}

- (IBAction)Accept:(id)sender {
    if ([schoolNameField.text length] == 0) {
        status.text = @"School Name field is required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    NSArray *results = [data retrieveSchools:schoolNameField.text];
    if (getData == @"Edit") {
        if ([schoolNameField.text length] == 0) {
            status.text = @"School name field is Required.";
        }
        else if ([schoolStartYearField.text length] == 0) {
            status.text = @"School start year field is Required.";
        }
        else {
        schoolName = schoolNameField.text;
        DataCollection *data = [[DataCollection alloc]init];
        NSArray *results = [data retrieveSchools:schoolName];
        if (results == nil){
            status.text = @"Database Error: Could not connect to Database.";
        }
        else {
            if ([results count] > 0) {
                NSLog(@"Save School Page");
                for (SchoolDetails *item in results){
                    item.schoolName = schoolNameField.text;
                    item.schoolDetails = schoolDetailsField.text;
                    item.schoolStartYear = schoolStartYearField.text;
                    item.schoolEndYear = schoolEndYearField.text;
                    item.schoolCalculatedGPA = calculatedGPAField.text;
                    item.schoolActualGPA = actualGPAField.text;
                }
                if ([data updateSchool:results] == 0){
                    [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
                else {
                    
                }
            }
        }
        }
    
    }else if ([results count] == 0){
        if ([schoolNameField.text length] == 0){
            status.text = @"School Name field is Required.";
        }
        else if ([schoolStartYearField.text length] == 0) {
            status.text = @"School start year field is Required.";
        }
    }
    else {
        int addResult = [data addSchool:(NSString *)schoolNameField.text schoolDetails:<#(NSString *)#>schoolDetailsField.text schoolStartYear:(NSString *)schoolStartYearField.text schoolEndYear:(NSString *)schoolEndYearField.text];
        if (addResult == 0) {
            if (getData == @"Edit") {
                schoolName = schoolNameField.text;
                [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
            }
            else {
                schoolName = schoolNameField.text;
                [self performSegueWithIdentifier:@"SelectGradingSchemeSegue" sender:self];
            }
            
        }
        else {
            status.text = @"Create school failed.";
        }
    }
    //else {
   //     status.text = @"School name already taken.";
    //}
}
    

- (IBAction)Cancel:(id)sender {
    if (getData == @"Edit") {
        [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
    }
}
@end
