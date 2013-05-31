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
@synthesize totalSemesterCount;
@synthesize totalCourseCount;
@synthesize totalCreditHours;
@synthesize desiredGPA;
@synthesize calculatedGPA;
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
    [self setTotalSemesterCount:nil];
    [self setTotalCourseCount:nil];
    [self setTotalCreditHours:nil];
    [self setDesiredGPA:nil];
    [self setCalculatedGPA:nil];
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
    int totCourses = 0;
    NSDecimalNumber *sumCredits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumDesiredUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumDesiredGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumCalculatedUnits = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumCalculatedGrades = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    NSDecimalNumber *sumSemesters = [self.schoolInfo valueForKeyPath:@"semesterDetails.@count"];
    
    if (self.schoolInfo.historicalGPA != nil && self.schoolInfo.historicalCredits != nil)
    {
        NSDecimalNumber *credits = [NSDecimalNumber decimalNumberWithMantissa:[self.schoolInfo.historicalCredits longValue] exponent:0 isNegative:NO];
        sumGrades = [sumGrades decimalNumberByAdding:self.schoolInfo.historicalGPA];
        sumGrades = [sumGrades decimalNumberByMultiplyingBy:credits];
        sumUnits = [sumUnits decimalNumberByAdding:credits];
        sumCredits = [sumCredits decimalNumberByAdding:credits];
        sumDesiredGrades = [sumDesiredGrades decimalNumberByAdding:self.schoolInfo.historicalGPA];
        sumDesiredGrades = [sumDesiredGrades decimalNumberByMultiplyingBy:credits];
        sumDesiredUnits = [sumDesiredUnits decimalNumberByAdding:credits];
    }

    for (SemesterDetails *semester in self.schoolInfo.semesterDetails)
    {
        sumCredits = [sumCredits decimalNumberByAdding:[semester valueForKeyPath:@"courseDetails.@sum.units"]];
        for (CourseDetails *item in semester.courseDetails)
        {
            totCourses ++;
            if (item.actualGradeGPA != nil && item.includeInGPA == [NSNumber numberWithInt:1] && item.actualGradeGPA.includeInGPA == [NSNumber numberWithInt:1])
            {
                sumCourses ++;
                NSDecimalNumber *units = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
                sumGrades = [sumGrades decimalNumberByAdding:[item.actualGradeGPA.gPA decimalNumberByMultiplyingBy:units]];
                sumUnits = [sumUnits decimalNumberByAdding:units];
                sumDesiredGrades = [sumDesiredGrades decimalNumberByAdding:[item.actualGradeGPA.gPA decimalNumberByMultiplyingBy:units]];
                sumDesiredUnits = [sumDesiredUnits decimalNumberByAdding:units];
            }
            else if (item.desiredGradeGPA != nil && item.includeInGPA == [NSNumber numberWithInt:1] && item.desiredGradeGPA.includeInGPA == [NSNumber numberWithInt:1])
            {
                NSDecimalNumber *units = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
                sumDesiredGrades = [sumDesiredGrades decimalNumberByAdding:[item.desiredGradeGPA.gPA decimalNumberByMultiplyingBy:units]];
                sumDesiredUnits = [sumDesiredUnits decimalNumberByAdding:units];
            }
            else if (item.actualGradeGPA.maxGrade != nil && item.includeInGPA == [NSNumber numberWithInt:1])// && item.actualGradeGPA.includeInGPA == [NSNumber numberWithInt:1])
            {
                NSDecimalNumber *units = [NSDecimalNumber decimalNumberWithMantissa:[item.units longValue] exponent:0 isNegative:NO];
                sumCalculatedUnits = [sumCalculatedUnits decimalNumberByAdding:units];
                for (GradingScheme *grade in self.schoolInfo.gradingScheme)
                {
                    if (item.actualGradeGPA.maxGrade <= grade.maxGrade && item.actualGradeGPA.maxGrade >= grade.minGrade)
                    {
                        sumCalculatedGrades = [sumCalculatedGrades decimalNumberByAdding:grade.gPA];
                        sumCalculatedGrades = [sumCalculatedGrades decimalNumberByMultiplyingBy:units];
                    }
                }
            }
        }
    }
    schoolCode.text = self.schoolInfo.schoolName;
    schoolName.text = self.schoolInfo.schoolDetails;
    schoolYears.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];
    semesterCount.text = [NSString stringWithFormat:@"%@",[sumSemesters stringValue]];
    courseCount.text = [NSString stringWithFormat:@"%d", sumCourses];
    creditHours.text = [NSString stringWithFormat:@"%@", [sumUnits stringValue]];
    totalSemesterCount.text = [NSString stringWithFormat:@"%@",[sumSemesters stringValue]];
    totalCourseCount.text = [NSString stringWithFormat:@"%d", totCourses];
    totalCreditHours.text = [NSString stringWithFormat:@"%@", [sumCredits stringValue]];

    NSDecimalNumber *gPA;
    NSDecimalNumber *dGPA;
    NSDecimalNumber *pGPA;
    if ([sumUnits longValue] == 0)
    {
        gPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        gPA = [sumGrades decimalNumberByDividingBy:sumUnits];
    }
    if ([sumDesiredUnits longValue] == 0)
    {
        dGPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        dGPA = [sumDesiredGrades decimalNumberByDividingBy:sumDesiredUnits];
    }
    if ([sumCalculatedUnits longValue] == 0)
    {
        pGPA = [NSDecimalNumber decimalNumberWithMantissa:0.00 exponent:0 isNegative:NO];
    }
    else
    {
        pGPA = [sumCalculatedGrades decimalNumberByDividingBy:sumCalculatedUnits];
    }
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    [nf setZeroSymbol:@"0.00"];
    NSString *nsGPA  = [nf stringFromNumber:gPA];
    cGPA.text = [NSString stringWithFormat:@"%@",nsGPA];
    NSString *nsDGPA  = [nf stringFromNumber:dGPA];
    desiredGPA.text = [NSString stringWithFormat:@"%@",nsDGPA];
    NSString *nsPGPA = [nf stringFromNumber:pGPA];
    calculatedGPA.text = [NSString stringWithFormat:@"%@",nsPGPA];
    
    
}

@end
