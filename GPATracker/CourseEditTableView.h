//
//  CourseEditTableView.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-22.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SemesterDetails;
@class CourseDetails;
@class DataCollection;

@interface CourseEditTableView : UITableViewController <UIPickerViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
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
@property (weak, nonatomic) IBOutlet UISwitch *courseEnableSyllabus;
@property (weak, nonatomic) IBOutlet UITextField *courseDescriptionField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setGradeType;
@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) SemesterDetails *semesterDetails;
@property (strong, nonatomic) CourseDetails *courseDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

-(IBAction)switchPassFail:(id)sender;

@end
