//
//  GradingSchemeSelectTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class SchoolDetails;
@class User;
@class DataCollection;
@class GradingScheme;

@interface GradingSchemeSelectTableView : UITableViewController
@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) GradingScheme *gradingInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
