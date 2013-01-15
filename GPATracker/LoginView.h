//
//  HTECHViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-03-17.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface LoginView : UIViewController

@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString *setLogoutStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) User *userInfo;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSelector;
@end
