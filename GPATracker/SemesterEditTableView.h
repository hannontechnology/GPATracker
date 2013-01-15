//
//  SemesterEditTableView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;
@class SchoolDetails;
@class SemesterDetails;

@interface SemesterEditTableView : UITableViewController <UIPickerViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *semesterNameField;
@property (weak, nonatomic) IBOutlet UITextField *semesterYearField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) NSString *setInputType;
@property (strong, nonatomic) SemesterDetails *semesterDetails;
@property (strong, nonatomic) SchoolDetails *schoolDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) User *userInfo;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

- (IBAction)showSemesterNamePicker:(id)sender;
- (IBAction)showSemesterYearPicker:(id)sender;

@end
