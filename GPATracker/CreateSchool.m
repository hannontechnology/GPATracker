//
//  CreateSchool.m
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateSchool.h"

@interface CreateSchool ()

@end

@implementation CreateSchool
@synthesize schoolName;
@synthesize schoolDetails;
@synthesize schoolStartYear;
@synthesize schoolEndYear;

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
    [self setSchoolName:nil];
    [self setSchoolDetails:nil];
    [self setSchoolStartYear:nil];
    [self setSchoolEndYear:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gradingScheme:(UIButton *)sender {
}

- (IBAction)Accept:(UIButton *)sender {
}

- (IBAction)Cancel:(UIButton *)sender {
}
@end
