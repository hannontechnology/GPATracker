//
//  GradingSchemeTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GradingSchemeTableView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "GradingScheme+Create.h"
#import "SchoolListTableView.h"
#import "SemesterEditTableView.h"

@interface GradingSchemeTableView ()
- (IBAction)Save:(id)sender;
@end

@implementation GradingSchemeTableView
@synthesize gradeDField;
@synthesize gradeFField;
@synthesize gradeAPlusField;
@synthesize gradeAField;
@synthesize gradeAMinusField;
@synthesize gradeBPlusField;
@synthesize gradeBField;
@synthesize gradeBMinusField;
@synthesize gradeCPlusField;
@synthesize gradeCField;
@synthesize gradeCMinusField;
@synthesize userInfo = _userInfo;
@synthesize schoolInfo = _schoolInfo;
@synthesize gradingInfo = _gradingInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

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
    [self setGradeAPlusField:nil];
    [self setGradeAField:nil];
    [self setGradeAMinusField:nil];
    [self setGradeBPlusField:nil];
    [self setGradeBField:nil];
    [self setGradeBMinusField:nil];
    [self setGradeCPlusField:nil];
    [self setGradeCField:nil];
    [self setGradeCField:nil];
    [self setGradeDField:nil];
    [self setGradeFField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //cancelButton.
    
    NSLog(@"viewWillAppear Event of GradingSchemeTableView");
    
    if (self.gradingInfo == nil)
    {
        NSLog(@"Database Error: Could not connect to Database");
    }
    else
    {
        NSLog(@"Load Grading Scheme Page");
        gradeAField.text = self.gradingInfo.gradeA.stringValue;
        gradeAMinusField.text = self.gradingInfo.gradeAMinus.stringValue;
        gradeAPlusField.text = self.gradingInfo.gradeAPlus.stringValue;
        gradeBField.text = self.gradingInfo.gradeB.stringValue;
        gradeBMinusField.text = self.gradingInfo.gradeBMinus.stringValue;
        gradeBPlusField.text = self.gradingInfo.gradeBPlus.stringValue;
        gradeCField.text = self.gradingInfo.gradeC.stringValue;
        gradeCMinusField.text = self.gradingInfo.gradeCMinus.stringValue;
        gradeCPlusField.text = self.gradingInfo.gradeCMinus.stringValue;
        gradeDField.text = self.gradingInfo.gradeD.stringValue;
        gradeFField.text = self.gradingInfo.gradeF.stringValue;
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Save:(id)sender
{
    if ([gradeAField.text length] == 0)
    {
        
        NSLog(@"A grade field is Required.");
        return;
    }
    else if ([gradeAMinusField.text length] == 0)
    {
        
        NSLog(@"A- grade field is Required.");
        return;
    }
    else if ([gradeAPlusField.text length] == 0)
    {
        
        NSLog(@"A+ grade field is Required.");
        return;
    }
    else if ([gradeBField.text length] == 0)
    {
        
        NSLog(@"B grade field is Required.");
        return;
    }
    else if ([gradeBMinusField.text length] == 0)
    {
        
        NSLog(@"B- grade field is Required.");
        return;
    }
    else if ([gradeBPlusField.text length] == 0)
    {
        
        NSLog(@"B+ grade field is Required.");
        return;
    }
    else if ([gradeCField.text length] == 0)
    {
        
        NSLog(@"C grade field is Required.");
        return;
    }
    else if ([gradeCMinusField.text length] == 0)
    {
        
        NSLog(@"C- grade field is Required.");
        return;
    }
    else if ([gradeCPlusField.text length] == 0)
    {
        
        NSLog(@"C+ grade field is Required.");
        return;
    }
    else if ([gradeDField.text length] == 0)
    {
        
        NSLog(@"D grade field is Required.");
        return;
    }
    else if ([gradeFField.text length] == 0)
    {
        
        NSLog(@"F grade field is Required.");
        return;
    }
    
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveGradingScheme:(NSString *)self.gradingInfo schoolName:(NSString *)self.schoolInfo.schoolName];
    
    if (self.gradingInfo == nil)
    {
        NSLog(@"Error: Could not connect to database.");
    }
    else
    {
        if ([results count] == 0) {
            NSString *entityName = @"GradingScheme";
            self.gradingInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:entityName
                                inManagedObjectContext:self.managedObjectContext];
            self.gradingInfo.school = self.schoolInfo;        }
        NSLog(@"Save Grading Scheme");
        self.gradingInfo.gradeA = [[NSDecimalNumber alloc] initWithString:(gradeAField.text)];
        self.gradingInfo.gradeAMinus = [[NSDecimalNumber alloc] initWithString:(gradeAMinusField.text)];
        self.gradingInfo.gradeAPlus = [[NSDecimalNumber alloc] initWithString:(gradeAPlusField.text)];
        self.gradingInfo.gradeB = [[NSDecimalNumber alloc] initWithString:(gradeBField.text)];
        self.gradingInfo.gradeBMinus = [[NSDecimalNumber alloc] initWithString:(gradeBMinusField.text)];
        self.gradingInfo.gradeBPlus = [[NSDecimalNumber alloc] initWithString:(gradeBPlusField.text)];
        self.gradingInfo.gradeC = [[NSDecimalNumber alloc] initWithString:(gradeCField.text)];
        self.gradingInfo.gradeCMinus = [[NSDecimalNumber alloc] initWithString:(gradeCMinusField.text)];
        self.gradingInfo.gradeCPlus = [[NSDecimalNumber alloc] initWithString:(gradeCPlusField.text)];
        self.gradingInfo.gradeD = [[NSDecimalNumber alloc] initWithString:(gradeDField.text)];
        self.gradingInfo.gradeF = [[NSDecimalNumber alloc] initWithString:(gradeFField.text)];
    }
    
    if ([self.managedObjectContext save:&error])
    {
        {
            [self performSegueWithIdentifier:@"segueGrading2Home" sender:self];
        }
    }
    else
    {
        NSLog(@"Saving Grading Scheme failed!");
    }
}

    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueGrading2Home"])
    {
        SchoolListTableView *SchoolListTableView = [segue destinationViewController];
        SchoolListTableView.userInfo = self.userInfo;
        SchoolListTableView.dataCollection = self.dataCollection;
        SchoolListTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueGrading2Semester"])
    {
        //SemesterEditTableView *SemesterEditTableView = [segue destinationViewController];
        
    }
}

#pragma mark - Table view data source

@end
