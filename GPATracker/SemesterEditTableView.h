//
//  SemesterEditTableView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCollection;
@class SchoolDetails;
@class SemesterDetails;

@interface SemesterEditTableView : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *semesterNameField;
@property (weak, nonatomic) IBOutlet UITextField *semesterYearField;
@property (weak, nonatomic) IBOutlet UITextField *semesterCodeField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setEditStatus;
//@property (strong, nonatomic) NSString *userName;
//@property (strong, nonatomic) NSString *schoolName;
//@property (strong, nonatomic) NSString *semesterName;
@property (strong, nonatomic) SemesterDetails *semesterDetails;
@property (strong, nonatomic) SchoolDetails *schoolDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
