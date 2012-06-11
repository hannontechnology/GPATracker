//
//  CreateProfile.m
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "CreateProfile.h"
#import "User.h"
#import "DataCollection.h"
#import "HomePage.h"

@interface CreateProfile ()

@end

@implementation CreateProfile
@synthesize headerText;
@synthesize dataCollection = _dataCollection;
@synthesize user = _user;
@synthesize usernameField;
@synthesize passwordField;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize autoLoginField;
@synthesize status;
@synthesize getData;
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.getData != @"Edit")
    {
        return;
    }
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:userName];
    
    if (results == nil)
    {
        status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Load Profile Page");
            headerText.title = @"Edit Profile";
            for (User *item in results)
            {
                usernameField.text  = item.userName;
                passwordField.text  = item.userPassword;
                firstNameField.text = item.userFirstName;
                lastNameField.text  = item.userLastName;
                emailField.text     = item.userEmail;
                if (item.autoLogon == [NSNumber numberWithInt:1])
                {
                    autoLoginField.on = YES;
                }
            }
        }
    }
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setEmailField:nil];
    [self setStatus:nil];
    [self setAutoLoginField:nil];
    [self setHeaderText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Accept:(id)sender
{
    if ([usernameField.text length] == 0)
    {
        status.text = @"Username field is Required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:usernameField.text];
    NSNumber *autoLogin = 0;
    
    if (getData == @"Edit")
    {
        if (autoLoginField.on)
        {
            autoLogin = [NSNumber numberWithInt:1];
        }
        if ([passwordField.text length] == 0)
        {
            status.text = @"Password field is Required.";
        }
        else if ([firstNameField.text length] == 0)
        {
            status.text = @"First Name field is Required.";
        }
        else if ([lastNameField.text length] == 0)
        {
            status.text = @"Last Name field is Required.";
        }
        else if ([emailField.text length] == 0)
        {
            status.text = @"Email field is Required.";
        }
        else
        {
            userName = usernameField.text;
            DataCollection *data = [[DataCollection alloc] init];
            
            //NSError *error = nil;
            NSArray *results = [data retrieveUsers:userName];
            
            if (results == nil)
            {
                status.text = @"Database Error: Could not connect to Database";
            }
            else
            {
                if ([results count] > 0)
                {
                    NSLog(@"Save Profile Page");
                    for (User *item in results)
                    {
                        item.userName      = usernameField.text;
                        item.userPassword  = passwordField.text;
                        item.userFirstName = firstNameField.text;
                        item.userLastName  = lastNameField.text;
                        item.userEmail     = emailField.text;
                        item.autoLogon     = autoLogin;
                    }
                    if ([data updateUser:results] == 0)
                    {
                        if (autoLoginField.on)
                        {
                            [data removeAutoLogin];
                            [data setAutoLogin:usernameField.text];
                        }
                        [self performSegueWithIdentifier: @"segueHomePage2" sender: self];
                    }
                    else 
                    {
                    }
                }
            }
        }      
    }
    else if ([results count] == 0)
    {
        if (autoLoginField.on)
        {
            autoLogin = [NSNumber numberWithInt:1];
        }
        if ([passwordField.text length] == 0)
        {
            status.text = @"Password field is Required.";
        }
        else if ([firstNameField.text length] == 0)
        {
            status.text = @"First Name field is Required.";
        }
        else if ([lastNameField.text length] == 0)
        {
            status.text = @"Last Name field is Required.";
        }
        else if ([emailField.text length] == 0)
        {
            status.text = @"Email field is Required.";
        }
        else
        {
            int addResult = [data addUser:(NSString *)usernameField.text userPassword:(NSString *)passwordField.text userFirstName:(NSString *)firstNameField.text userLastName:(NSString *)lastNameField.text userEmail:(NSString *)emailField.text autoLogin:(NSNumber *)autoLogin];
            if (addResult == 0)
            {
                if (autoLoginField.on)
                {
                    [data removeAutoLogin];
                    [data setAutoLogin:usernameField.text];
                }
               [self performSegueWithIdentifier: @"segueHomePage2" sender: self];
            }
            else 
            {
                status.text = @"Create user failed!";
            }
        }
    }
    else
    {
        status.text = @"Username already taken.";
    }    
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueHomePage2"])
	{
        HomePage *HomePage = [segue destinationViewController];
        
        HomePage.userName = userName;
	}
}
@end
