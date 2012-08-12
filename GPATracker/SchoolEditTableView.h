//
//  SchoolEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataCollection;
@class User;
@class SchoolDetails;
@class GradingSchemeSelectTableView;

@interface SchoolEditTableView : UITableViewController
@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
@property (weak, nonatomic) IBOutlet UITextField *schoolDetailsField;
@property (weak, nonatomic) IBOutlet UITextField *schoolStartYearField;
@property (weak, nonatomic) IBOutlet UITextField *schoolEndYearField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setEditStatus;

@property (weak, nonatomic) IBOutlet UITableViewCell *gradingScheme;


@end
