//
//  CourseEditTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseEditTableView : UITableViewController
@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *schoolName;
@property (strong, nonatomic) NSString *semesterName;
@property (strong, nonatomic) NSString *courseCode;
@property (weak, nonatomic) IBOutlet UITextField *courseCodeField;
@property (weak, nonatomic) IBOutlet UITextField *courseNameField;
@property (weak, nonatomic) IBOutlet UITextField *courseUnitsField;
@property (weak, nonatomic) IBOutlet UITextField *courseDesiredGradeField;
@property (weak, nonatomic) IBOutlet UITextField *courseActualGradeField;
@property (weak, nonatomic) IBOutlet UISwitch *coursePassFailField;
@property (weak, nonatomic) IBOutlet UISwitch *courseIncludeInGPAField;
@property (weak, nonatomic) IBOutlet UITextField *courseDescriptionField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@end
