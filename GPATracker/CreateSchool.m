//
//  CreateSchool.m
//  GPATracker
//
//  Created by David Stevens on 12-05-29.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "CreateSchool.h"

@interface CreateSchool ()

@end

@implementation CreateSchool
@synthesize dataCollection = _dataCollection;
@synthesize school = _school;
@synthesize schoolnameField;
@synthesize schooldetailField;
@synthesize schoolstartyearField;
@synthesize schoolendyearField;


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
    [self setSchoolnameField:nil];
    [self setSchooldetailField:nil];
    [self setSchoolstartyearField:nil];
    [self setSchoolendyearField:nil];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Accept:(id)sender
{
    if ([schoolnameField.text length] == 0)
    {
        
    }
        
}
@end
