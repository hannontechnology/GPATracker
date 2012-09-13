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

@interface GradingSchemeTableView : CoreDataTableViewController

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong,nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) GradingScheme *gradingInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
