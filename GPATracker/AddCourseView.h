//
//  AddCourseView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface AddCourseView : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *courseID;
@property (weak, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITextField *units;
@property (weak, nonatomic) IBOutlet UITextField *desiredGrade;
@property (weak, nonatomic) IBOutlet UITextField *actualGrade;
@property (weak, nonatomic) IBOutlet UITextField *description;

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
