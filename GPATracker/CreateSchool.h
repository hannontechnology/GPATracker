//
//  CreateSchool.h
//  GPATracker
//
//  Created by David Stevens on 12-05-29.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class School;
@class gradingScheme;
@class DataCollection;

@interface CreateSchool : UIViewController

@property (strong, nonatomic) School * school;
@property (strong, nonatomic) DataCollection *dataCollection;

@property (weak, nonatomic) IBOutlet UITextField *schoolnameField;
@property (weak, nonatomic) IBOutlet UITextField * schooldetailField;
@property (weak, nonatomic) IBOutlet UITextField * schoolstartyearField;
@property (weak, nonatomic) IBOutlet UITextField * schoolendyearField;
- (IBAction)Accept:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)SetGradingScheme:(id)sender;

@end
