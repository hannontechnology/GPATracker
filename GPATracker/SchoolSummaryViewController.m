//
//  SchoolSummaryViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-11-18.
//
//

#import "SchoolSummaryViewController.h"
#import "SchoolDetails+Create.h"

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
    [self DisplaySchool:self.schoolInfo];
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

-(void)DisplaySchool:(SchoolDetails *)inSchool
{
    self.schoolInfo = inSchool;
    
    NSLog(@"School Name: %@", inSchool.schoolName);
    
    schoolCode.text = self.schoolInfo.schoolName;
    schoolName.text = self.schoolInfo.schoolDetails;
    schoolYears.text = [NSString stringWithFormat:@"%@ - %@", [self.schoolInfo schoolStartYear], [self.schoolInfo schoolEndYear]];
    cGPA.text = [NSString stringWithFormat:@"0.00"];
    semesterCount.text = [NSString stringWithFormat:@"0"];
    courseCount.text = [NSString stringWithFormat:@"0"];
    creditHours.text = [NSString stringWithFormat:@"0"];
}

@end
