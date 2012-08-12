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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([segue.identifier isEqualToString:@"segue2GradingConfirm"])
   {
       GradingSchemeTableView *GradingSchemeTableView = [segue destinationViewController];
       GradingSchemeTableView.userInfo = self.userInfo;
       GradingSchemeTableView.DataCollection = self.dataCollection;
       GradingSchemeTableView.schoolInfo = self.schoolInfo;
       GradingSchemeTableView.gradingInfo = self.gradingInfo;
       GradingSchemeTableView.managedObjectContext = self.managedObjectContext;
   }
}
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveGradingScheme:(NSString *)self.gradingInfo schoolName:(NSString *)self.schoolInfo.schoolName];
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.row == 0) {
        
       if ([results count]==0)
       {
           NSString *entityName = @"GradingScheme";
           self.gradingInfo = [NSEntityDescription
            insertNewObjectForEntityForName:entityName
            inManagedObjectContext:self.managedObjectContext];
           self.gradingInfo.school = self.schoolInfo;
       }
        //Populate Grading Scheme database
        self.gradingInfo.letterGrade = @"A+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.00)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        
        
        
        
    } else if (indexPath.row == 1){
        if ([results count]==0)
        {
            NSString *entityName = @"GradingScheme";
            self.gradingInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:entityName
                                inManagedObjectContext:self.managedObjectContext];
            self.gradingInfo.school = self.schoolInfo;
        }
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        
    } else if (indexPath.row == 2){
        if ([results count]==0)
        {
            NSString *entityName = @"GradingScheme";
            self.gradingInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:entityName
                                inManagedObjectContext:self.managedObjectContext];
            self.gradingInfo.school = self.schoolInfo;
        }
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
    }
     //GradingSchemeTableView *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
    if ([self.managedObjectContext save:&error])
    {
        NSLog(@"Save Successful");
        GradingSchemeTableView *gradingSchemeTableView = [[GradingSchemeTableView alloc] initWithNibName:@"gradingSchemeTableView" bundle:nil];
        [self.navigationController pushViewController:gradingSchemeTableView animated:YES];
        
    }
    else
    {
        NSLog(@"Create school failed!");
    }
    
}

@end
