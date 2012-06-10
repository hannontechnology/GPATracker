//
//  HTECHViewController.m
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "HTECHViewController.h"
#import "User.h"
#import "DataCollection.h"

@interface HTECHViewController ()
@end

@implementation HTECHViewController
@synthesize dataCollection = _dataCollection;
@synthesize user = _user;
@synthesize userNameField;
@synthesize passwordField;
@synthesize status;
@synthesize autoLoginSelector;
@synthesize getData;
@synthesize userName;


- (IBAction)Login:(id)sender
{
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:userNameField.text];

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

    results = [data retrieveUsers:userNameField.text userPassword:passwordField.text];
    
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
                [data removeAutoLogin];
                [data setAutoLogin:userNameField.text];
            }
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

- (IBAction)CreateProfile:(id)sender
{
    
}

- (IBAction)setAutoLogin:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.getData == @"Logout")
    {
        return;
    }
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveAutoLogin];
    
    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Goto Home Page");
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
@end
