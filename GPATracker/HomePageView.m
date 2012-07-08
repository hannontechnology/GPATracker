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
#import "DataCollection.h"
#import "SchoolDetails.h"

@interface HomePageView ()

@end

@implementation HomePageView
@synthesize userName;
@synthesize schoolTitle;
@synthesize schoolSubTitle;
@synthesize homePageTableView;
@synthesize homePageCell;
@synthesize schoolList;

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
    DataCollection *data = [[DataCollection alloc] init];
    
    self.userName = @"terryah";

    //NSError *error = nil;
    schoolList = [data retrieveSchoolList:(NSString *)self.userName];
    
    if (schoolList == nil)
    {
        return;
    }
    else
    {
        if ([schoolList count] > 0)
        {
            NSLog(@"School List:");
            for (SchoolDetails *item in schoolList)
            {
                NSLog(@"School Found: %@ - %@",item.schoolName, item.schoolDetails);
            }
        }
    }

    [super viewDidLoad];
    
    [self.homePageTableView reloadData];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    //return [schoolList count];
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"homePageCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    homePageCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(homePageCell == nil) {
        homePageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    SchoolDetails *selectedObject = [schoolList objectAtIndex:indexPath.row];
//    homePageCell.textLabel.text = [selectedObject schoolName];
    schoolTitle.text = [selectedObject schoolName];
    
    return homePageCell;
}

- (void)viewDidUnload
{
    [self setSchoolTitle:nil];
    [self setSchoolSubTitle:nil];
    [self setHomePageCell:nil];
    [self setHomePageTableView:nil];
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
    else if ([segue.identifier isEqualToString:@"EditSchoolSegue"])
    {
        SchoolEditView *SchoolEditView = [segue destinationViewController];
        
        SchoolEditView.getData  = @"Edit";
        SchoolEditView.userName = userName;
    }
    else if ([segue.identifier isEqualToString:@"CreateSchoolSegue"])
    {
        SchoolEditView *SchoolEditView = [segue destinationViewController];
        
        SchoolEditView.userName = userName;
    }
}

- (IBAction)EditSchool:(id)sender {
}

- (IBAction)AddSchool:(id)sender {
}
@end
