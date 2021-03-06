//
//  ProfileEditTableView.m
//  GPATracker
//
//  Created by Terry Hannon on 12-07-11.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "ProfileEditTableView.h"
#import "User+Create.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "LoginView.h"
#import "SchoolEditTableView.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

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

@synthesize userInfo = _userInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize setCancel = _setCancel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    if (section == 1)
    {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[CustomFooter alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.setCancel = @"N";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (keyboardToolbar == nil)
    {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 44.0)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.alpha = 0.2;
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(prevField:)];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextField:)];
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneKey:)];
        
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:prevButton, nextButton, extraSpace, doneButton, nil]];
    }
    
    firstNameField.inputAccessoryView = keyboardToolbar;
    lastNameField.inputAccessoryView = keyboardToolbar;
    emailField.inputAccessoryView = keyboardToolbar;
    userNameField.inputAccessoryView = keyboardToolbar;
    passwordField.inputAccessoryView = keyboardToolbar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) doneKey:(id)sender
{
    if ([firstNameField isFirstResponder])
        [firstNameField resignFirstResponder];
    else if ([lastNameField isFirstResponder])
        [lastNameField resignFirstResponder];
    else if ([emailField isFirstResponder])
        [emailField resignFirstResponder];
    else if ([userNameField isFirstResponder])
        [userNameField resignFirstResponder];
    else if ([passwordField isFirstResponder])
        [passwordField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([userNameField isFirstResponder] && self.setEditStatus != (NSString *)@"Edit")
    {
        [userNameField resignFirstResponder];
        [emailField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[emailField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([passwordField isFirstResponder] && self.setEditStatus != (NSString *)@"Edit")
    {
        [passwordField resignFirstResponder];
        [userNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[userNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([passwordField isFirstResponder] && self.setEditStatus == (NSString *)@"Edit")
    {
        [passwordField resignFirstResponder];
        [emailField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[emailField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([firstNameField isFirstResponder])
    {
        [firstNameField resignFirstResponder];
        [passwordField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[passwordField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([lastNameField isFirstResponder])
    {
        [lastNameField resignFirstResponder];
        [firstNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[firstNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([emailField isFirstResponder])
    {
        [emailField resignFirstResponder];
        [lastNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[lastNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([firstNameField isFirstResponder])
    {
        [firstNameField resignFirstResponder];
        [lastNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[lastNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([lastNameField isFirstResponder])
    {
        [lastNameField resignFirstResponder];
        [emailField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[emailField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([emailField isFirstResponder] && self.setEditStatus != (NSString *)@"Edit")
    {
        [emailField resignFirstResponder];
        [userNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[userNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([emailField isFirstResponder] && self.setEditStatus == (NSString *)@"Edit")
    {
        [emailField resignFirstResponder];
        [passwordField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[passwordField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([userNameField isFirstResponder] && self.setEditStatus != (NSString *)@"Edit")
    {
        [userNameField resignFirstResponder];
        [passwordField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[passwordField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([passwordField isFirstResponder])
    {
        [passwordField resignFirstResponder];
        [firstNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[firstNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //cancelButton.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
    self.navigationItem.leftBarButtonItem = cancelButton;

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
    if (self.setEditStatus == (NSString *)@"Edit")
        userNameField.enabled = NO;
    else
        userNameField.enabled = YES;
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
        autoLogin = [NSNumber numberWithBool:YES];
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

    if (self.setEditStatus == (NSString *)@"Edit")
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
                
                NSArray *schooList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
                if ([schooList count] == 0)
                {
                    [self performSegueWithIdentifier: @"segueProfile2Login" sender: self];
                }
                else
                {
                    if (self.navigationController == nil)
                        [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
                    else
                        [self.navigationController popViewControllerAnimated:YES];
                }
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
            
            NSArray *schooList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
            if ([schooList count] == 0)
            {
                [self performSegueWithIdentifier: @"segueProfile2Login" sender: self];
            }
            else
            {
                if (self.navigationController == nil)
                    [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
                else
                    [self.navigationController popViewControllerAnimated:YES];
            }
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
    UIActionSheet *popUp = [[UIActionSheet alloc] initWithTitle:@"Discard Changes" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    [popUp showFromTabBar:self.view];
}

- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet.title = %@", actionSheet.title);
    if (buttonIndex == 0)
    {
        NSLog(@"User Click the Yes button");
        if (self.setEditStatus != (NSString *)@"Edit")
        {
            [self performSegueWithIdentifier: @"segueProfile2Login" sender: self];
        }
        else
        {
            if (self.navigationController == nil)
                [self performSegueWithIdentifier: @"segueProfile2HomePage" sender: self];
            else
                [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"User Click the No button");
        // Maybe do something else
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
        SchoolListTableView *SchoolListTableView = [segue destinationViewController];
        
        SchoolListTableView.userInfo = self.userInfo;
        SchoolListTableView.dataCollection = self.dataCollection;
        SchoolListTableView.managedObjectContext = self.managedObjectContext;
	}
	else if ([segue.identifier isEqualToString:@"segueProfile2Login"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        if (self.setCancel == (NSString *)@"Y")
            LoginView.setLogoutStatus = @"Logout";
        LoginView.dataCollection = self.dataCollection;
        LoginView.managedObjectContext = self.managedObjectContext;
	}
    else if ([segue.identifier isEqualToString:@"segueLoginCreateSchool"])
    {
        SchoolEditTableView *SchoolEditTableView = [segue destinationViewController];
        
        SchoolEditTableView.userInfo = self.userInfo;
        SchoolEditTableView.dataCollection = self.dataCollection;
        SchoolEditTableView.managedObjectContext = self.managedObjectContext;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
