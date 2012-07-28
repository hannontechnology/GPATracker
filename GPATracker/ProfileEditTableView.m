//
//  ProfileEditTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileEditTableView.h"
#import "User+Create.h"
#import "DataCollection.h"
#import "HomePageTableView.h"
#import "LoginView.h"

@interface ProfileEditTableView ()

- (IBAction)Accept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation ProfileEditTableView
@synthesize headerText;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize userNameField;
@synthesize passwordField;
@synthesize autoLoginField;

@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize userInfo = _userInfo;

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

    if (self.userInfo == nil)
    {
        //status.text = @"Database Error: Could not connect to Database";
    }
    else
    {
        NSLog(@"Load Profile Page");
        headerText.title = @"Edit Profile";
        userNameField.text  = self.userInfo.userName;
        passwordField.text  = self.userInfo.userPassword;
        firstNameField.text = self.userInfo.userFirstName;
        lastNameField.text  = self.userInfo.userLastName;
        emailField.text     = self.userInfo.userEmail;
        if (self.userInfo.autoLogon == [NSNumber numberWithInt:1])
        {
            autoLoginField.on = YES;
        }
    }
    userNameField.enabled = NO;
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
    NSNumber *autoLogin = 0;
    if (autoLoginField.on)
    {
        autoLogin = [NSNumber numberWithInt:1];
    }

    if ([userNameField.text length] == 0)
    {
        NSLog(@"UserName field is Required.");
        return;
    }
    else if ([passwordField.text length] == 0)
    {
        NSLog(@"Password field is Required.");
        return;
    }
    else if ([firstNameField.text length] == 0)
    {
        NSLog(@"First Name field is Required.");
        return;
    }
    else if ([lastNameField.text length] == 0)
    {
        NSLog(@"Last Name field is Required.");
        return;
    }
    else if ([emailField.text length] == 0)
    {
        NSLog(@"Email field is Required.");
        return;
    }
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveUsers:userNameField.text inContext:self.managedObjectContext];

    if (self.setEditStatus == @"Edit")
    {
        if (self.userInfo == nil)
        {
            NSLog(@"Database Error: Could not connect to Database");
        }
        else
        {
            NSLog(@"Save Profile Page");
            self.userInfo.userName      = userNameField.text;
            self.userInfo.userPassword  = passwordField.text;
            self.userInfo.userFirstName = firstNameField.text;
            self.userInfo.userLastName  = lastNameField.text;
            self.userInfo.userEmail     = emailField.text;
            self.userInfo.autoLogon     = autoLogin;
            if ([[self managedObjectContext] save:&error])
            {
                NSLog(@"Save was successful");
                if (autoLoginField.on)
                {
                    [self.userInfo removeAutoLogin:self.userInfo context:self.managedObjectContext];
                }
                [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
            }
            else 
            {
                NSLog(@"Save Error! - %@",error.userInfo);
            }
        }      
    }
    else if ([results count] == 0)
    {
        self.userInfo = [NSEntityDescription
                         insertNewObjectForEntityForName:@"User"
                         inManagedObjectContext:self.managedObjectContext];
        self.userInfo.userName      = userNameField.text;
        self.userInfo.userPassword  = passwordField.text;
        self.userInfo.userFirstName = firstNameField.text;
        self.userInfo.userLastName  = lastNameField.text;
        self.userInfo.userEmail     = emailField.text;
        self.userInfo.autoLogon     = autoLogin;
            
        if ([self.managedObjectContext save:&error])
        {
            if (autoLoginField.on)
            {
                [self.userInfo removeAutoLogin:self.userInfo context:self.managedObjectContext];
            }
            [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
        }
        else 
        {
            NSLog(@"Create user failed!");
        }
    }
    else
    {
        NSLog(@"Username already taken.");
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
        HomePageTableView *HomePageTableView = [segue destinationViewController];
        
        HomePageTableView.userInfo = self.userInfo;
        HomePageTableView.dataCollection = self.dataCollection;
        HomePageTableView.managedObjectContext = self.managedObjectContext;
	}
	else if ([segue.identifier isEqualToString:@"segueProfile2Login"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.setLogoutStatus = @"Logout";
        LoginView.dataCollection = self.dataCollection;
        LoginView.managedObjectContext = self.managedObjectContext;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
