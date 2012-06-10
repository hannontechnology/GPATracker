//
//  HomePage.m
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "HomePage.h"
#import "HTECHViewController.h"
#import "CreateProfile.h"

@interface HomePage ()

@end

@implementation HomePage
@synthesize userName;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueLogout"])
	{
        HTECHViewController *HTECHViewController = [segue destinationViewController];
        
        HTECHViewController.getData = @"Logout";
	}
    else if ([segue.identifier isEqualToString:@"segueEditProfile"])
    {
        CreateProfile *CreateProfile = [segue destinationViewController];
        
        CreateProfile.getData = @"Edit";
    }
}
@end
