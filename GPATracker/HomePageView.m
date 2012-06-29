//
//  HomePage.m
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "HomePageView.h"
#import "LoginView.h"
#import "ProfileEditView.h"
#import "SchoolEditView.h"

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
        ProfileEditView *ProfileEditView = [segue destinationViewController];
        
        ProfileEditView.getData  = @"Edit";
        ProfileEditView.userName = userName;
    }
    else if ([segue.identifier isEqualToString:@"AddEditSchoolSegue"])
    {
        SchoolEditView *SchoolEditView = [segue destinationViewController];
        
        SchoolEditView.getData  = @"Edit";
        SchoolEditView.userName = userName;
    }
}
- (IBAction)EditSchool:(id)sender {
}

- (IBAction)AddSchool:(id)sender {
}
@end
