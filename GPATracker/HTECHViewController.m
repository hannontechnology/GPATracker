//
//  HTECHViewController.m
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTECHViewController.h"
#import "User.h"

@interface HTECHViewController ()

@end

@implementation HTECHViewController
@synthesize managedObjectContext;
@synthesize userNameField;
@synthesize passwordField;
@synthesize status;


- (IBAction)Login:(id)sender
{
    NSManagedObjectContext *moc = [self managedObjectContext];

    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"User.userName = %@ and User.password = %@", userNameField.text, passwordField.text];
    NSLog(@"filtering data based on User.userName = %@ and User.password = %@", userNameField.text, passwordField.text);

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (results == nil)
    {
        status.text = @"Username or Password incorrect";
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
