//
//  SchoolSummaryViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-11-18.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SchoolSummaryViewController.h"
#import "SchoolDetails+Create.h"
#import "SemesterDetails+Create.h"
#import "CourseDetails.h"
#import "GradingScheme+Create.h"
#import "LoginView.h"

@interface SchoolSummaryViewController ()

@end

@implementation SchoolSummaryViewController
@synthesize schoolCode;
@synthesize schoolName;
@synthesize schoolYears;
@synthesize cGPA;
@synthesize semesterCount;
@synthesize courseCount;
@synthesize creditHours;
@synthesize schoolInfo = _schoolInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self DisplayInfo];
}

- (void)viewDidUnload
{
    [self setSchoolCode:nil];
    [self setSchoolName:nil];
    [self setSchoolYears:nil];
    [self setCGPA:nil];
    [self setSemesterCount:nil];
    [self setCourseCount:nil];
    [self setCreditHours:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)DisplayInfo
{
    NSLog(@"School Name: %@", self.schoolInfo.schoolName);

    int sumCourses = 0;
    NSDecimalNumber *sumCredits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumSemesters = [self.schoolInfo valueForKeyPath:@"semesterDetails.@count"];
    for (SemesterDetails *semester in self.schoolInfo.semesterDetails)
    {
        sumCredits = [sumCredits decimalNumberByAdding:[semester valueForKeyPath:@"courseDetails.@sum.units"]];
        for (CourseDetails *item in semester.courseDetails)
        {
            sumCourses ++;
            if (item.actualGradeGPA != nil && item.includeInGPA == [NSNumber numberWithInt:1])
            {
                NSDecimalNumber *units = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
                sumGrades = [sumGrades decimalNumberByAdding:[item.actualGradeGPA.gPA decimalNumberByMultiplyingBy:units]];
                sumUnits = [sumUnits decimalNumberByAdding:units];
            }
        }
    }
    schoolCode.text = self.schoolInfo.schoolName;
    schoolName.text = self.schoolInfo.schoolDetails;
    schoolYears.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];
    semesterCount.text = [NSString stringWithFormat:@"%@",[sumSemesters stringValue]];
    courseCount.text = [NSString stringWithFormat:@"%d", sumCourses];
    creditHours.text = [NSString stringWithFormat:@"%@", [sumCredits stringValue]];

    NSDecimalNumber *gPA;
    if ([sumUnits longValue] == 0)
    {
        gPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        gPA = [sumGrades decimalNumberByDividingBy:sumUnits];
    }
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    [nf setZeroSymbol:@"0.00"];
    NSString *ns  = [nf stringFromNumber:gPA];
    cGPA.text = [NSString stringWithFormat:@"%@",ns];
}

@end
