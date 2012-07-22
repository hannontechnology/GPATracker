//
//  SemesterTableView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemesterTableView : UITableViewController

@property (strong, nonatomic) NSArray *semesterList;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *schoolName;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end
