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

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end
