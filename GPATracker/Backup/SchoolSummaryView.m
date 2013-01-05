//
//  SchoolSummaryView.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-12.
//
//

#import "SchoolSummaryView.h"

@implementation SchoolSummaryView
@synthesize schoolCode;
@synthesize schoolName;
@synthesize schoolYears;
@synthesize cGPA;
@synthesize semesterCount;
@synthesize courseCount;
@synthesize creditCount;
@synthesize schoolInfo = _schoolInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)DisplaySchool:(SchoolDetails *)inSchool
{
    self.schoolInfo = inSchool;
    
    schoolCode.text = self.schoolInfo.schoolName;
    schoolName.text = self.schoolInfo.schoolDetails;
    schoolYears.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];
    cGPA.text = [NSString stringWithFormat:@"0.00"];
    semesterCount.text = [NSString stringWithFormat:@"0"];
    courseCount.text = [NSString stringWithFormat:@"0"];
    creditCount.text = [NSString stringWithFormat:@"0"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
