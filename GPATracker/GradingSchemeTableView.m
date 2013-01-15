//
//  GradingSchemeTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "GradingSchemeTableView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "GradingScheme+Create.h"
#import "SchoolListTableView.h"
#import "SemesterEditTableView.h"
#import "GradingSchemeCell1.h"

@interface GradingSchemeTableView ()
- (IBAction)Save:(id)sender;
@end

@implementation GradingSchemeTableView
@synthesize userInfo = _userInfo;
@synthesize schoolInfo = _schoolInfo;
@synthesize gradingInfo = _gradingInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize tableView = _tableView;

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
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"gPA" ascending:NO]];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"letterGrade" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat: @"school = %@", self.schoolInfo];
    NSLog(@"filtering data based on school = %@", self.schoolInfo);
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"gradeCache"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gradingSchemeTableCell1";
    GradingSchemeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[GradingSchemeCell1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.cellLabel1.text = [selectedObject letterGrade];
    NSDecimalNumber *gPA = [selectedObject gPA];
    cell.cellField1.text = gPA.stringValue;
    
    NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], gPA.stringValue);
    
    return cell;
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
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Save:(id)sender
{
    NSError *error = nil;
    
    for (int i=0;i<[self.tableView numberOfRowsInSection:0];i++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        GradingSchemeCell1 *cell = [[self tableView] cellForRowAtIndexPath:ip];
        if (cell == nil)
        {
            NSLog(@"Index Row: %d",[ip row]);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0]-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            cell = [[self tableView] cellForRowAtIndexPath:ip];
            if (cell == nil)
            {
                NSLog(@"Index Row: %d",[ip row]);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                cell = [[self tableView] cellForRowAtIndexPath:ip];                
            }
        }
        GradingScheme *selectedObject = [self.fetchedResultsController objectAtIndexPath:ip];
        NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);

        selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
    }

    //NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.gradingInfo context:self.managedObjectContext];

    if (self.gradingInfo == nil)
    {
        NSLog(@"Error: Could not connect to database.");
    }
    //if ([results count] != 0)
    //{
        [self.managedObjectContext save:&error];
    //}

    [self performSegueWithIdentifier:@"segueGrading2Home" sender:self];
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
