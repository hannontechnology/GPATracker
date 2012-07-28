//
//  HTECHViewController.m
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "LoginView.h"
#import "User+Create.h"
#import "DataCollection.h"
#import "HomePageTableView.h"
#import "ProfileEditTableView.h"

@interface LoginView ()
- (IBAction)Login:(id)sender;
- (IBAction)ForgotPassword:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end

@implementation LoginView
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize userInfo = _userInfo;

@synthesize userNameField;
@synthesize passwordField;
@synthesize autoLoginSelector;
@synthesize status;

@synthesize setLogoutStatus = _setLogoutStatus;
@synthesize userName;

- (void)viewWillAppear:(BOOL)animated
{
    self.dataCollection = [[DataCollection alloc] init];
    self.managedObjectContext = [self.dataCollection managedObjectContext];
    [super viewWillAppear:(BOOL)animated];
}

- (IBAction)Login:(id)sender
{
    NSError *error = nil;
    NSArray *results = [self.userInfo retrieveUsers:userNameField.text inContext:self.managedObjectContext];

    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] == 0)
        {
            status.text = @"Username not found";
            return;
        }
    }

    results = [self.userInfo retrieveUsers:userNameField.text userPassword:passwordField.text inContext:self.managedObjectContext];
    
    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] == 0)
        {
            status.text = @"Password incorrect";
            return;
        }
        else
        {
            if (autoLoginSelector.on)
            {
                self.userInfo = [results objectAtIndex:0];
                [self.userInfo removeAutoLogin:self.userInfo context:self.managedObjectContext];
                [self.userInfo setAutoLogin:self.userInfo context:self.managedObjectContext];
            }
            userName = userNameField.text;
            [self performSegueWithIdentifier: @"segueHomePage" sender: self];
        }
    }
}

- (IBAction)ForgotPassword:(id)sender
{
    UIActionSheet *popUp = [[UIActionSheet alloc] initWithTitle:@"Forgot Password" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset Password" otherButtonTitles:nil];
    
    [popUp showInView:self.view];
}

- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"User Clicked Reset Password");
            break;
        case 1:
            NSLog(@"User Clicked Cancel");
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.setLogoutStatus== @"Logout")
    {
        return;
    }
    //NSError *error = nil;
    NSArray *results = [self.userInfo retrieveAutoLogin:self.managedObjectContext];
    
    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Goto Home Page");
            self.userInfo = [results objectAtIndex:0];
            [self performSegueWithIdentifier: @"segueHomePage" sender: self];
        }
    }
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setStatus:nil];
    [self setAutoLoginSelector:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else
    {
        return YES;
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueHomePage"])
	{
        UINavigationController *navCon = [segue destinationViewController];
        HomePageTableView *HomePageTableView = [navCon.viewControllers objectAtIndex:0];
        
        HomePageTableView.userInfo = self.userInfo;
        HomePageTableView.dataCollection = self.dataCollection;
        HomePageTableView.managedObjectContext = self.managedObjectContext;
	}
	else if ([segue.identifier isEqualToString:@"segueCreateProfile"])
	{
        UINavigationController *navCon = [segue destinationViewController];
        ProfileEditTableView *ProfileEditTableView = [navCon.viewControllers objectAtIndex:0];
        
        ProfileEditTableView.dataCollection = self.dataCollection;
        ProfileEditTableView.managedObjectContext = self.managedObjectContext;
	}
}
@end
