//
//  GradingSchemeTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradingSchemeTableView : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *gradeAPlusField;

@property (weak, nonatomic) IBOutlet UITextField *gradeAField;
@property (weak, nonatomic) IBOutlet UITextField *gradeAMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBPlusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBField;
@property (weak, nonatomic) IBOutlet UITextField *gradeBMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCPlusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCField;
@property (weak, nonatomic) IBOutlet UITextField *gradeCMinusField;
@property (weak, nonatomic) IBOutlet UITextField *gradeDField;
@property (weak, nonatomic) IBOutlet UITextField *gradeFField;

@end
