//
//  GradingSchemeView.m
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GradingSchemeView.h"

@interface GradingSchemeView ()

@end

@implementation GradingSchemeView
@synthesize gradeAPlus;
@synthesize gradeA;
@synthesize gradeAMinus;
@synthesize gradeBPlus;
@synthesize gradeB;
@synthesize gradeBMinus;
@synthesize gradeCPlus;
@synthesize gradeC;
@synthesize gradeCMinus;
@synthesize gradeD;
@synthesize gradeF;

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
}

- (void)viewDidUnload
{
    [self setGradeAPlus:nil];
    [self setGradeA:nil];
    [self setGradeAMinus:nil];
    [self setGradeBPlus:nil];
    [self setGradeB:nil];
    [self setGradeBMinus:nil];
    [self setGradeCPlus:nil];
    [self setGradeC:nil];
    [self setGradeCMinus:nil];
    [self setGradeD:nil];
    [self setGradeF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Done:(UIBarButtonItem *)sender {
}
@end
