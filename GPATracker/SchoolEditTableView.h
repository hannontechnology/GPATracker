//
//  SchoolEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class SelectGradingSchemeView;

@interface SchoolEditTableView : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *schoolNameField;
@property (strong, nonatomic) NSString *setStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *schoolName;

@property (weak, nonatomic) IBOutlet UITextField *schoolDetailsField;
@property (weak, nonatomic) IBOutlet UITextField *schoolStartYearField;
@property (weak, nonatomic) IBOutlet UITextField *schoolEndYearField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

- (IBAction)gradingScheme:(UIButton *)sender;

@end
