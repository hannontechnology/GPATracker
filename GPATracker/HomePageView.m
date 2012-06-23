//
//  HomePage.m
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "HomePageView.h"
#import "LoginView.h"
#import "ProfileView.h"
#import "SchoolView.h"

@interface HomePageView ()

@end

@implementation HomePageView
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
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.getData  = @"Logout";
        LoginView.userName = userName;
	}
    else if ([segue.identifier isEqualToString:@"segueEditProfile"])
    {
        ProfileView *ProfileView = [segue destinationViewController];
        
        ProfileView.getData  = @"Edit";
        ProfileView.userName = userName;
    }
    else if ([segue.identifier isEqualToString:@"AddEditSchoolSegue"])
    {
        //Terry fix here, your changes messed up my create school view.  I needed to fix that, sorry about your code. :(
    }
}
- (IBAction)EditSchool:(id)sender {
}

- (IBAction)AddSchool:(id)sender {
}
@end
