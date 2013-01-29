//
//  GradingSchemeSelectTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
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
    self.navigationItem.hidesBackButton = YES;

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
       GradingSchemeTableView.gradingInfo = [self.schoolInfo.gradingScheme.allObjects objectAtIndex:0];
       GradingSchemeTableView.managedObjectContext = self.managedObjectContext;
   }
}
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.schoolInfo context:self.managedObjectContext];
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.row == 0)
    {
        //Populate Grading Scheme database
        NSString *entityName = @"GradingScheme";
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(95)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(100)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(89)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(94)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(86)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(88)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(80)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(85)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(76)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(79)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(72)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(75)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(68)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(71)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(64)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(67)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(1.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(60)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(63)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"D";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(1.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(50)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(59)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(49)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"P";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(50)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(100)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:NO];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(49)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
    }
    else if (indexPath.row == 1)
    {
        //Populate Grading Scheme database
        NSString *entityName = @"GradingScheme";
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(4.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(95)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(100)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(89)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(94)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(86)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(88)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(3.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(80)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(85)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(76)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(79)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(72)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(75)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(2.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(68)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(71)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(1.67)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(64)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(67)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"D";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(1.33)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(60)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(63)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(59)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"P";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(60)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(100)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:NO];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(59)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
    }
    else if (indexPath.row == 2)
    {
        //Populate Grading Scheme database
        NSString *entityName = @"GradingScheme";
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"A-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"B-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C+";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"C-";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"D";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:NO];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"P";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:NO];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
        self.gradingInfo = [NSEntityDescription
                            insertNewObjectForEntityForName:entityName
                            inManagedObjectContext:self.managedObjectContext];
        self.gradingInfo.school = self.schoolInfo;
        self.gradingInfo.letterGrade = @"F";
        self.gradingInfo.gPA = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
        self.gradingInfo.minGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.maxGrade = [[NSDecimalNumber alloc]initWithDouble:(0)];
        self.gradingInfo.includeInGPA = [NSNumber numberWithBool:YES];
        self.gradingInfo.isPassFail = [NSNumber numberWithBool:YES];
        [self.managedObjectContext save:nil];
    }
     //GradingSchemeTableView *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
    if ([self.managedObjectContext save:&error])
    {
        NSLog(@"Save Successful");
        //GradingSchemeTableView *gradingSchemeTableView = [[GradingSchemeTableView alloc] initWithNibName:@"gradingSchemeTableView" bundle:nil];
        //[self.navigationController pushViewController:gradingSchemeTableView animated:YES];
        [self performSegueWithIdentifier:@"segue2GradingConfirm" sender:self];
        
    }
    else
    {
        NSLog(@"Create school failed!");
    }
    
}

@end
