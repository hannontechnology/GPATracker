//
//  GradingSchemeSelectTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SchoolDetails;
@class User;
@class DataCollection;
@class GradingScheme;

@interface GradingSchemeSelectTableView : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *gradingAPlus433;
@property (weak, nonatomic) IBOutlet UITableViewCell *gradingAPlus400;
@property (weak, nonatomic) IBOutlet UITableViewCell *gradingCustom;
@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
