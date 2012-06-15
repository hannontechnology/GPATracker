//
//  GradingSchemeView.h
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradingScheme;
@class DataCollection;

@interface GradingSchemeView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *gradeAPlus;
@property (weak, nonatomic) IBOutlet UITextField *gradeA;
@property (weak, nonatomic) IBOutlet UITextField *gradeAMinus;
@property (weak, nonatomic) IBOutlet UITextField *gradeBPlus;
@property (weak, nonatomic) IBOutlet UITextField *gradeB;
@property (weak, nonatomic) IBOutlet UITextField *gradeBMinus;
@property (weak, nonatomic) IBOutlet UITextField *gradeCPlus;
@property (weak, nonatomic) IBOutlet UITextField *gradeC;
@property (weak, nonatomic) IBOutlet UITextField *gradeCMinus;
@property (weak, nonatomic) IBOutlet UITextField *gradeD;
@property (weak, nonatomic) IBOutlet UITextField *gradeF;

@end
