//
//  HomePageViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-08-07.
//
//

#import "HomePageViewController.h"
#import "User+Create.h"
#import "DataCollection.h"
#import "SchoolListTableView.h"
#import "LoginView.h"
#import "ProfileEditTableView.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController
@synthesize userInfo = _userInfo;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

-(IBAction)schoolList:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePage2SchoolList" sender: self];
}

-(IBAction)semesterList:(id)sender
{
    
}

-(IBAction)courseList:(id)sender
{
    
}

-(IBAction)profile:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePage2ProfileEdit" sender: self];
}

-(IBAction)logout:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePageLogout" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueHomePage2SchoolList"])
	{
        SchoolListTableView *SchoolListTableView = [segue destinationViewController];
        
        SchoolListTableView.userInfo = self.userInfo;
        SchoolListTableView.dataCollection = self.dataCollection;
        SchoolListTableView.managedObjectContext = self.managedObjectContext;
        SchoolListTableView.showEdit = @"N";
	}
	else if ([segue.identifier isEqualToString:@"segueHomePageLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.setLogoutStatus = @"Logout";
        LoginView.userInfo = self.userInfo;
        LoginView.dataCollection = self.dataCollection;
	}
    else if ([segue.identifier isEqualToString:@"segueHomePage2ProfileEdit"])
    {
        ProfileEditTableView *ProfileEditTableView = [segue destinationViewController];
        
        ProfileEditTableView.setEditStatus = @"Edit";
        ProfileEditTableView.userInfo = self.userInfo;
        ProfileEditTableView.dataCollection = self.dataCollection;
        ProfileEditTableView.managedObjectContext = self.managedObjectContext;
    }
}

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

@end
