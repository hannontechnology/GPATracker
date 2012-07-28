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

@interface GradingSchemeTableView ()

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

@end
