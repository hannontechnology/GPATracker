//
//  SchoolSummaryView.h
//  GPATracker
//
//  Created by Terry Hannon on 12-09-12.
//
//

#import <UIKit/UIKit.h>
#import "SchoolDetails+Create.h"

@class SchoolDetails;

@interface SchoolSummaryView : UIView
@property (weak, nonatomic) IBOutlet UILabel *schoolCode;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *schoolYears;
@property (weak, nonatomic) IBOutlet UILabel *cGPA;
@property (weak, nonatomic) IBOutlet UILabel *semesterCount;
@property (weak, nonatomic) IBOutlet UILabel *courseCount;
@property (weak, nonatomic) IBOutlet UILabel *creditCount;

@property (strong, nonatomic) SchoolDetails *schoolInfo;

-(void)DisplaySchool:(SchoolDetails *)inSchool;

@end
