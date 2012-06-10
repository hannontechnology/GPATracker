//
//  CreateSchool.m
//  GPATracker
//
//  Created by David Stevens on 12-05-29.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "CreateSchool.h"
#import "School.h"
#import "DataCollection.h"

@interface CreateSchool ()

@end

@implementation CreateSchool
@synthesize dataCollection = _dataCollection;
@synthesize school = _school;
@synthesize schoolnameField;
@synthesize schooldetailField;
@synthesize schoolstartyearField;
@synthesize schoolendyearField;
@synthesize status;


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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Accept:(id)sender
{
    int addResult;
    
    if ([schoolnameField.text length] == 0)
    {
        status.text = @"School Name is Required.";
    }
    
    DataCollection *data = [DataCollection alloc];
    //NSError *error = nil;
    NSArray *results = [data retrieveSchools:schoolnameField.text];
    
    if ([results count] == 0)
    {
        if ([schooldetailField.text length] == 0)
        {
            status.text = @"School Detail Field is Required.";
        }
        else if ([schoolstartyearField.text length] == 0)
        {
            status.text = @"School Start Year field is Required.";
        }
        else
        {
            addResult = [data addSchool:(NSString *)schoolnameField.text schoolDetail:(NSString *)schooldetailField.text schoolStartYear:(NSDate *)schoolstartyearField.text schoolEndYear:(NSDate *)schoolendyearField.text];
        }
            if (addResult == 0)
            {
                [self performSegueWithIdentifier: @"segueCSchoolHome" sender: self];
            }
            else 
            {
                status.text = @"Create user failed!";
            }
    }
    else
    {
        status.text = @"School Name already taken.";
    }    
   
        
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

@end
