//
//  SemesterEditTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterEditTableView.h"
#import "SemesterDetails.h"
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
@synthesize userName = _userName;
@synthesize schoolName = _schoolName;
@synthesize semesterName = _semesterName;
@synthesize semester;
@synthesize dataCollection;

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
    
    DataCollection *data = [[DataCollection alloc] init];
    
    NSArray *results = [data retrieveSemester:self.semesterName schoolName:self.schoolName userName:self.userName];
    
    if(results == nil)
    {
        // TODO: put in Error checking
    }
    else 
    {
        if([results count] > 0)
        {
            NSLog(@"Loading Semester Edit Page");
            headerText.title = @"Edit Semester";
            
            for(SemesterDetails *item in results)
            {
                semesterNameField.text = item.semesterName;
                semesterYearField.text = [NSString stringWithFormat:@"%@", [item semesterYear].stringValue];
                semesterCodeField.text = [NSString stringWithFormat:@"%@", [item semesterCode].stringValue];
            }
        }
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
    if(([semesterNameField.text length] == 0) || ([semesterYearField.text length] == 0))
    {
        // TODO: Error message
        return;
    }
    
    DataCollection *data = [DataCollection alloc];
    
    NSArray *results = [data retrieveSemester:self.semesterName schoolName:self.schoolName userName:self.userName];
    
    // TODO: add in logic for creating automated semester code
    
    if(self.setEditStatus == @"Edit")
    {
        if([semesterNameField.text length] == 0)
        {
            // TODO: Error message
        }
        else if([semesterYearField.text length] == 0)
        {
            // TODO: Error message
        }
        else 
        {
            // Find semester and edit it
            DataCollection *data = [[DataCollection alloc] init];
            
            NSArray *results = [data retrieveSemester:self.semesterName schoolName:self.schoolName userName:self.userName];
            
            if(results == nil)
            {
                //TODO: Error message
            }
            else if ([results count] > 0)
            {
                NSLog(@"Save Semester Page");
                for(SemesterDetails *item in results)
                {
                    item.semesterName = semesterNameField.text;
                    
                    // Cast text to NSNumber:
                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    [f setNumberStyle:NSNumberFormatterNoStyle];
                    NSNumber *s_year = [f numberFromString:semesterYearField.text];
                    item.semesterYear = s_year;
                    NSNumber *s_code = [f numberFromString:semesterCodeField.text];
                    item.semesterCode = s_code;
                }
            }
            else {
                // TODO: default behaviour = do nothing
            }
        }
    }
    else if ([results count] == 0)
    {
        if ([semesterNameField.text length] == 0)
        {
            // TODO: error message
        }
        else if ([semesterYearField.text length] == 0)
        {
            // TODO: error message
        }
        else 
        {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterNoStyle];
            
            int addResult = [data addSemester:(NSString *)semesterNameField.text semesterYear:(NSNumber *)[f numberFromString:semesterYearField.text] semesterCode:(NSNumber *)[f numberFromString:semesterCodeField.text] userName:(NSString *)self.userName schoolName:(NSString *)self.schoolName];
            
            if(addResult == 0)
            {
                self.semesterName = semesterNameField.text;
                [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
            }
            else 
            {
                // TODO: Error message
            }
        }
    }
    else 
    {
        // TODO: Error message - "Semester already exists"
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
        SemesterTableView.userName = self.userName;
        SemesterTableView.schoolName = self.schoolName;
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
