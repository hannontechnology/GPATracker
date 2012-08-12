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
@synthesize gPAField;
@synthesize letterGradeField;
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

- (void)setupFetchedResultsController
{
    NSString *entityName = @"GradingScheme";
    NSLog(@"Seeting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"letterGrade" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat: @"school = %@", self.schoolInfo];
    NSLog(@"filtering data based on school = %@", self.schoolInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
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
    [self setGPAField:nil];
    [self setLetterGradeField:nil];
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
        gPAField.text = self.gradingInfo.gPA.stringValue;
        letterGradeField.text = self.gradingInfo.letterGrade;
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Save:(id)sender
{
    if ([gPAField.text length] == 0)
    {
        
        NSLog(@"GPA field is Required.");
        return;
    }
    else if ([letterGradeField.text length] == 0)
    {
        
        NSLog(@"Letter Grade field is Required.");
        return;
    }
    
    
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveGradingScheme:(NSString *)self.gradingInfo school:(SchoolDetails *)self.schoolInfo];
    
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
        self.gradingInfo.letterGrade = letterGradeField.text;
        self.gradingInfo.gPA = [[NSDecimalNumber alloc] initWithString:(gPAField.text)];
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
}

#pragma mark - Table view data source

@end
