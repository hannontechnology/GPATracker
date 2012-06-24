//
//  CreateSchoolView.h
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCollection;

@interface CreateSchoolView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *SchoolName;
@property (weak, nonatomic) IBOutlet UITextField *SchoolDetails;
@property (weak, nonatomic) IBOutlet UITextField *SchoolStartYear;
@property (weak, nonatomic) IBOutlet UITextField *SchoolEndYear;
- (IBAction)EditGradingScheme:(id)sender;
- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
