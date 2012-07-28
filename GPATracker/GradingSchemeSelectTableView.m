//
//  GradingSchemeSelectTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GradingSchemeSelectTableView.h"
#import "GradingSchemeTableView.h"
#import "GradingScheme+Create.h"
#import "SchoolDetails.h"
#import "DataCollection.h"

@interface GradingSchemeSelectTableView ()

@end

@implementation GradingSchemeSelectTableView
@synthesize gradingAPlus433;
@synthesize gradingAPlus400;
@synthesize gradingCustom;
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
//    [self setGradingAPlus433:nil];
//    [self setGradingAPlus400:nil];
//    [self setGradingCustom:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.row == 0) {
        GradingSchemeTableView *gradingSchemeTableView = [[GradingSchemeTableView alloc] initWithNibName:@"gradingSchemeTableView" bundle:nil];
    }
     //GradingSchemeTableView *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
