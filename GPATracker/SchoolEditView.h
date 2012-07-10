//
//  CreateSchoolView.h
//  GPATracker
//
//  Created by David Stevens on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCollection;
@class SchoolDetails;
@class SelectGradingSchemeView;

@interface SchoolEditView : UIViewController
@property (strong, nonatomic) SchoolDetails *school;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSString *schoolName;
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
@property (weak, nonatomic) IBOutlet UITextField *schoolDetailsField;
@property (weak, nonatomic) IBOutlet UITextField *schoolStartYearField;
@property (weak, nonatomic) IBOutlet UITextField *schoolEndYearField;
@property (weak, nonatomic) IBOutlet UITextField *calculatedGPAField;
@property (weak, nonatomic) IBOutlet UITextField *actualGPAField;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) NSString *getData;
@property (strong, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

- (IBAction)EditGradingScheme:(id)sender;
- (IBAction)Save:(UIBarButtonItem *)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end
