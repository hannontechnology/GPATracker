//
//  HTECHViewController.h
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTECHViewController : UIViewController

- (IBAction)Login:(id)sender;
- (IBAction)ForgotPassword:(id)sender;
- (IBAction)CreateProfile:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end
