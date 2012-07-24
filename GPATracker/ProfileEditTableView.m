//
//  ProfileEditTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileEditTableView.h"
#import "User.h"
#import "DataCollection.h"
#import "HomePageTableView.h"
#import "LoginView.h"

@interface ProfileEditTableView ()

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation ProfileEditTableView
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize setEditStatus = _setEditStatus;
@synthesize userName = _userName;
@synthesize userNameField;
@synthesize passwordField;
@synthesize autoLoginField;
@synthesize headerText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //cancelButton.
    
    if (self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:self.userName];
    
    if (results == nil)
    {
        //status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        if ([results count] > 0)
        {
            NSLog(@"Load Profile Page");
            headerText.title = @"Edit Profile";
            for (User *item in results)
            {
                userNameField.text  = item.userName;
                passwordField.text  = item.userPassword;
                firstNameField.text = item.userFirstName;
                lastNameField.text  = item.userLastName;
                emailField.text     = item.userEmail;
                if (item.autoLogon == [NSNumber numberWithInt:1])
                {
                    autoLoginField.on = YES;
                }
            }
            userNameField.enabled = NO;
        }
    }
}

- (void)viewDidUnload
{
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setEmailField:nil];
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setAutoLoginField:nil];
    [self setHeaderText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)Accept:(id)sender
{
    if ([userNameField.text length] == 0)
    {
        //status.text = @"Username field is Required.";
        return;
    }
    DataCollection *data = [DataCollection alloc];
    
    //NSError *error = nil;
    NSArray *results = [data retrieveUsers:userNameField.text];
    NSNumber *autoLogin = 0;
    
    if (self.setEditStatus == @"Edit")
    {
        if (autoLoginField.on)
        {
            autoLogin = [NSNumber numberWithInt:1];
        }
        if ([passwordField.text length] == 0)
        {
            //status.text = @"Password field is Required.";
        }
        else if ([firstNameField.text length] == 0)
        {
            //status.text = @"First Name field is Required.";
        }
        else if ([lastNameField.text length] == 0)
        {
            //status.text = @"Last Name field is Required.";
        }
        else if ([emailField.text length] == 0)
        {
            //status.text = @"Email field is Required.";
        }
        else
        {
            self.userName = userNameField.text;
            DataCollection *data = [[DataCollection alloc] init];
            
            //NSError *error = nil;
            NSArray *results = [data retrieveUsers:self.userName];
            
            if (results == nil)
            {
                //status.text = @"Database Error: Could not connect to Database";
            }
            else
            {
                if ([results count] > 0)
                {
                    NSLog(@"Save Profile Page");
                    for (User *item in results)
                    {
                        item.userName      = userNameField.text;
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
                            [data setAutoLogin:userNameField.text];
                        }
                        [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
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
            //status.text = @"Password field is Required.";
        }
        else if ([firstNameField.text length] == 0)
        {
            //status.text = @"First Name field is Required.";
        }
        else if ([lastNameField.text length] == 0)
        {
            //status.text = @"Last Name field is Required.";
        }
        else if ([emailField.text length] == 0)
        {
            //status.text = @"Email field is Required.";
        }
        else
        {
            int addResult = [data addUser:(NSString *)userNameField.text userPassword:(NSString *)passwordField.text userFirstName:(NSString *)firstNameField.text userLastName:(NSString *)lastNameField.text userEmail:(NSString *)emailField.text autoLogin:(NSNumber *)autoLogin];
            if (addResult == 0)
            {
                if (autoLoginField.on)
                {
                    [data removeAutoLogin];
                    [data setAutoLogin:userNameField.text];
                }
                self.userName = userNameField.text;
                [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
            }
            else 
            {
                //status.text = @"Create user failed!";
            }
        }
    }
    else
    {
        //status.text = @"Username already taken.";
    }    
}

- (IBAction)Cancel:(id)sender
{
    if (self.setEditStatus == @"Edit")
    {
        [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
    }
    else
    {
        [self performSegueWithIdentifier: @"segueProfile2Login" sender: self];
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueProfile2HomePage"])
	{
//        UINavigationController *navCon = [segue destinationViewController];
//        HomePageTableView *HomePageTableView = [navCon.viewControllers objectAtIndex:0];
        HomePageTableView *HomePageTableView = [segue destinationViewController];
        
        HomePageTableView.userName = self.userName;
	}
	else if ([segue.identifier isEqualToString:@"segueProfile2Login"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.getData  = @"Logout";
        LoginView.userName = self.userName;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
