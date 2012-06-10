//
//  HTECHViewController.h
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HTECHViewController : UIViewController

- (IBAction)Login:(id)sender;
- (IBAction)ForgotPassword:(id)sender;
- (IBAction)CreateProfile:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)setAutoLogin:(id)sender;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSString *getData;
@property (strong, nonatomic) NSString *userName;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSelector;
@end
