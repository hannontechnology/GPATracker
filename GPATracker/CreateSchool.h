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
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;

@property (weak, nonatomic) IBOutlet UITextField * schooldetailField;
@property (weak, nonatomic) IBOutlet UITextField * schoolstartyearField;
@property (weak, nonatomic) IBOutlet UITextField * schoolendyearField;
@property (weak, nonatomic) IBOutlet UILabel * status;
- (IBAction)Accept:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)SetGradingScheme:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
