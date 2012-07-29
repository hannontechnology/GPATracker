//
//  SemesterEditTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterEditTableView.h"
#import "SemesterDetails+Create.h"
#import "DataCollection.h"
#import "SemesterTableView.h"

@interface SemesterEditTableView ()
- (IBAction)Accept:(UIBarButtonItem *)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end

@implementation SemesterEditTableView
@synthesize semesterNameField;
@synthesize semesterYearField;
@synthesize semesterCodeField;
@synthesize headerText;
@synthesize setEditStatus;
//@synthesize userName = _userName;
//@synthesize schoolName = _schoolName;
//@synthesize semesterName = _semesterName;
@synthesize schoolDetails = _schoolDetails;
@synthesize semesterDetails = _semesterDetails;
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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Cancel Button
    
    if(self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    
    if(self.semesterDetails == nil)
    {
        // TODO: put in Error checking
    }
    else 
    {
        NSLog(@"Loading Semester Edit Page");
        headerText.title = @"Edit Semester";
        semesterNameField.text = self.semesterDetails.semesterName;
        semesterYearField.text = [NSString stringWithFormat:@"%@", [self.semesterDetails semesterYear].stringValue];
        semesterCodeField.text = [NSString stringWithFormat:@"%@", [self.semesterDetails semesterCode].stringValue];
    }
}

- (void)viewDidUnload
{
    [self setSemesterNameField:nil];
    [self setSemesterNameField:nil];
    [self setSemesterYearField:nil];
    [self setSemesterCodeField:nil];
    [self setHeaderText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)Accept:(id)sender
{
    // TODO: add in check for repeat semesters
    
    if([semesterNameField.text length] == 0)
    {
        // TODO: Error message
    }
    else if([semesterYearField.text length] == 0)
    {
        // TODO: Error message
    }
    
    NSArray *results = [self.dataCollection retrieveSemester:semesterNameField.text schoolDetails:self.schoolDetails context:self.managedObjectContext];
    
    // TODO: add in logic for creating automated semester code
    
    if(self.setEditStatus == @"Edit")
    {
        if(self.semesterDetails == nil)
        {
            //TODO: Error message
        }
        else
        {
            NSLog(@"Save Semester Page");
            self.semesterDetails.semesterName = semesterNameField.text;
                    
            // Cast text to NSNumber:
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterNoStyle];
            NSNumber *s_year = [f numberFromString:semesterYearField.text];
            self.semesterDetails.semesterYear = s_year;
            NSNumber *s_code = [f numberFromString:semesterCodeField.text];
            self.semesterDetails.semesterCode = s_code;

            if ([self.managedObjectContext save:nil])
            {
                [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
            }
            else
            {
                NSLog(@"Save Semester Failed! :(");
            }
        }
    }
    else if ([results count] == 0)
    {
        NSString *entityName = @"SemesterDetails";
        self.semesterDetails = [NSEntityDescription
                                  insertNewObjectForEntityForName:entityName
                                  inManagedObjectContext:self.managedObjectContext];
        self.semesterDetails.semesterName = semesterNameField.text;
        
        // Cast text to NSNumber:
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *s_year = [f numberFromString:semesterYearField.text];
        self.semesterDetails.semesterYear = s_year;
        NSNumber *s_code = [f numberFromString:semesterCodeField.text];
        self.semesterDetails.semesterCode = s_code;
        self.semesterDetails.schoolDetails = self.schoolDetails;
        
        if ([self.managedObjectContext save:nil])
        {
            [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
        }
        else
        {
            NSLog(@"Save Semester Failed! :(");
        }
    }
    else
    {
        NSLog(@"Save Semester Failed! Semester Already Exist!");
    }
}

- (IBAction)Cancel:(id)sender
{
        [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueEditSemesterToSemester"])
    {
        SemesterTableView *SemesterTableView = [segue destinationViewController];
        SemesterTableView.schoolInfo = self.schoolDetails;
        SemesterTableView.managedObjectContext = self.managedObjectContext;
        SemesterTableView.dataCollection = self.dataCollection;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

@end
