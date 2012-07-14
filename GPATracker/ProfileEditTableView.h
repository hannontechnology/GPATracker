//
//  ProfileEditTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileEditTableView : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) NSString *setStatus;
@property (strong, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@end
