//
//  CreateSchoolView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCollection;
@class SchoolDetails;

@interface CreateSchoolView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *SchoolName;
@property (weak, nonatomic) IBOutlet UITextField *SchoolDetails;
@property (weak, nonatomic) IBOutlet UITextField *SchoolStartYear;
@property (weak, nonatomic) IBOutlet UITextField *SchoolEndYear;
@property (weak, nonatomic) IBOutlet UITextField *CalculatedGPA;
@property (weak, nonatomic) IBOutlet UITextField *ActualGPA;

- (IBAction)EditGradingScheme:(id)sender;
- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
