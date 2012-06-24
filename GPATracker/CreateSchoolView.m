//
//  CreateSchoolView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateSchoolView.h"

@implementation CreateSchoolView
@synthesize SchoolName;
@synthesize SchoolDetails;
@synthesize SchoolStartYear;
@synthesize SchoolEndYear;
@synthesize CalculatedGPA;
@synthesize ActualGPA;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSchoolName:nil];
    [self setSchoolDetails:nil];
    [self setSchoolStartYear:nil];
    [self setSchoolEndYear:nil];
    [self setCalculatedGPA:nil];
    [self setActualGPA:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)EditGradingScheme:(id)sender {
}

- (IBAction)Accept:(id)sender {
}

- (IBAction)Cancel:(id)sender {
}
@end
