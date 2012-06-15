//
//  CreateSchool.h
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchoolDetails;
@class DataCollection;

@interface CreateSchool : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *schoolName;
@property (weak, nonatomic) IBOutlet UITextField *schoolDetails;
@property (weak, nonatomic) IBOutlet UITextField *schoolStartYear;
@property (weak, nonatomic) IBOutlet UITextField *schoolEndYear;

- (IBAction)gradingScheme:(UIButton *)sender;
- (IBAction)Accept:(UIButton *)sender;
- (IBAction)Cancel:(UIButton *)sender;

@end
