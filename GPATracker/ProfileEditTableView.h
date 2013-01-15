//
//  ProfileEditTableView.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-11.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface ProfileEditTableView : UITableViewController
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginField;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) NSString *setCancel;

@end
