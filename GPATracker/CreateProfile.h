//
//  CreateProfile.h
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface CreateProfile : UIViewController

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSString *getData;
@property (strong, nonatomic) NSString *userName;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginField;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)Accept:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end
