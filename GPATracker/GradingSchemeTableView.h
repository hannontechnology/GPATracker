//
//  GradingSchemeTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class SchoolDetails;
@class DataCollection;
@class GradingScheme;

@interface GradingSchemeTableView : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *gradeAPlusField;

@property (weak, nonatomic) IBOutlet UITextField *gradeAField;
@property (weak, nonatomic) IBOutlet UITextField *gradeAMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBPlusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCPlusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeDField;
@property (weak, nonatomic) IBOutlet UITextField *gradeFField;

@property (strong,nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) GradingScheme *gradingInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
