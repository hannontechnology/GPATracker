//
//  CourseEditTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SemesterDetails;
@class CourseDetails;
@class DataCollection;

@interface CourseEditTableView : UITableViewController
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *courseCodeField;
@property (weak, nonatomic) IBOutlet UITextField *courseNameField;
@property (weak, nonatomic) IBOutlet UITextField *courseUnitsField;
@property (weak, nonatomic) IBOutlet UITextField *courseDesiredGradeField;
@property (weak, nonatomic) IBOutlet UITextField *courseActualGradeField;
@property (weak, nonatomic) IBOutlet UISwitch *coursePassFailField;
@property (weak, nonatomic) IBOutlet UISwitch *courseIncludeInGPAField;
@property (weak, nonatomic) IBOutlet UITextField *courseDescriptionField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setGradeType;
@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) SemesterDetails *semesterDetails;
@property (strong, nonatomic) CourseDetails *courseDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

-(IBAction)desiredGradeChange:(id)sender;
-(IBAction)actualGradeChange:(id)sender;
-(IBAction)showDesiredGradePicker:(id)sender;
-(IBAction)showActualGradePicker:(id)sender;

@end
