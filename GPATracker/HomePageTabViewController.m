//
//  HomePageTabViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "HomePageTabViewController.h"
#import "SchoolSummaryViewController.h"
#import "DataCollection.h"
#import "User+Create.h"
#import "LoginView.h"
#import "ProfileEditTableView.h"
#import "SchoolEditTableView.h"
#import "SemesterTableView.h"
#import "SemesterEditTableView.h"
#import "CourseEditTableView.h"

@interface HomePageTabViewController ()
@end

@implementation HomePageTabViewController
@synthesize buttonLogout;
@synthesize buttonEditProfile;
@synthesize buttonSemesterList;
@synthesize buttonSchoolList;
@synthesize buttonNext;
@synthesize buttonPrevious;
@synthesize buttonAddSchool;
@synthesize buttonEditSchool;

- (void)viewWillAppear:(BOOL)animated
{
    if (self.userInfo == nil)
        return;

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (self.displayType == nil)
    {
        self.displayType = @"Schools";
    }
    
    if (self.displayType == (NSString *)@"Schools")
    {
        [self viewSchools];
    }
    else if (self.displayType == (NSString *)@"Semesters")
    {
        [self viewSemesters];
    }
    else if (self.displayType == (NSString *)@"Courses")
    {
        [self viewCourses];
    }
    [buttonEditSchool setTitle:@"Edit" forState:UIControlStateNormal];
    
    UIImage *faceImage = [UIImage imageNamed:@"BlueHomeButton.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    buttonSchoolList = faceBtn;
}

- (void)viewDidLoad
{
    if (self.userInfo == nil)
        return;
    
    [super viewDidLoad];
    
    if (self.displayType == nil)
    {
        self.displayType = @"Schools";
    }
    
    if (self.displayType == (NSString *)@"Schools")
    {
        [self viewSchools];
    }
    else if (self.displayType == (NSString *)@"Semesters")
    {
        [self viewSemesters];
    }
    else if (self.displayType == (NSString *)@"Courses")
    {
        [self viewCourses];
    }
    [buttonEditSchool setTitle:@"Edit" forState:UIControlStateNormal];
    
    UIImage *faceImage = [UIImage imageNamed:@"BlueHomeButton.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    buttonSchoolList = faceBtn;
}

-(IBAction)DisplaySchools:(id)sender
{
    self.displayType = @"Schools";
    [self viewSchools];
}

-(IBAction)DisplaySemesters:(id)sender
{
    self.displayType = @"Semesters";
    [self viewSemesters];
}

-(IBAction)DisplayCourses:(id)sender
{
    self.displayType = @"Courses";
    [self viewCourses];
}

- (void)viewSchools
{
    int tmpPage = self.pageControl.currentPage;
    for (SchoolSummaryViewController *item in self.childViewControllers)
    {
        [item.view removeFromSuperview];
        [item removeFromParentViewController];
    }
    
    self.schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    
    for (SchoolDetails *item in self.schoolList)
    {
        SchoolSummaryViewController *View = [self.storyboard instantiateViewControllerWithIdentifier:@"SchoolSummaryView"];
        
        View.dataCollection = self.dataCollection;
        View.managedObjectContext = self.managedObjectContext;
        View.schoolInfo = item;
        [View DisplayInfo];
        
        [self addChildViewController:View];
    }
    
    self.pageControl.numberOfPages = self.schoolList.count;
//    [self viewWillAppear:true];
    [super viewWillAppear:true];
    [self selectPage:tmpPage];
}

- (void)viewSemesters
{
    int tmpPage = self.pageControl.currentPage;
    for (SchoolSummaryViewController *item in self.childViewControllers)
    {
        [item.view removeFromSuperview];
        [item removeFromParentViewController];
    }
    
    self.schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    
    for (SchoolDetails *item in self.schoolList)
    {
        SemesterTableView *View = [self.storyboard instantiateViewControllerWithIdentifier:@"SemesterListView"];
        
        View.dataCollection = self.dataCollection;
        View.managedObjectContext = self.managedObjectContext;
        View.schoolInfo = item;
        View.userInfo = self.userInfo;
        [View DisplayInfo];
        
        [self addChildViewController:View];
    }
    
    self.pageControl.numberOfPages = self.schoolList.count;
    //    [self viewWillAppear:true];
    [super viewWillAppear:true];
    [self selectPage:tmpPage];
}

- (void)viewCourses
{
    int tmpPage = self.pageControl.currentPage;
    for (SchoolSummaryViewController *item in self.childViewControllers)
    {
        [item.view removeFromSuperview];
        [item removeFromParentViewController];
    }
    
    self.schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    
    for (SchoolDetails *item in self.schoolList)
    {
        SemesterTableView *View = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseListView"];
        
        View.dataCollection = self.dataCollection;
        View.managedObjectContext = self.managedObjectContext;
        View.schoolInfo = item;
        View.userInfo = self.userInfo;
        [View DisplayInfo];
        
        [self addChildViewController:View];
    }
    
    self.pageControl.numberOfPages = self.schoolList.count;
    //    [self viewWillAppear:true];
    [super viewWillAppear:true];
    [self selectPage:tmpPage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.displayType == (NSString *)@"Schools")
    {
        //SchoolSummaryViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        //[newViewController DisplayInfo];
    }
    else if (self.displayType == (NSString *)@"Semesters")
    {
        //SemesterTableView *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        //[newViewController DisplayInfo];
    }
    else if (self.displayType == (NSString *)@"Courses")
    {
        //SemesterTableView *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        //[newViewController DisplayInfo];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueHomePageLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.setLogoutStatus = @"Logout";
        LoginView.userInfo = self.userInfo;
        LoginView.dataCollection = self.dataCollection;
        LoginView.managedObjectContext = self.managedObjectContext;
	}
    else if ([segue.identifier isEqualToString:@"segueHomePageEditProfile"])
    {
        ProfileEditTableView *ProfileEditTableView = [segue destinationViewController];
        
        ProfileEditTableView.setEditStatus = @"Edit";
        ProfileEditTableView.userInfo = self.userInfo;
        ProfileEditTableView.dataCollection = self.dataCollection;
        ProfileEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueHomePageEditSchool"])
    {
        SchoolDetails *selectedObject = [self.schoolList objectAtIndex:self.pageControl.currentPage];
        SchoolEditTableView *SchoolEditTableView = [segue destinationViewController];
        
        SchoolEditTableView.setEditStatus = @"Edit";
        SchoolEditTableView.userInfo = self.userInfo;
        SchoolEditTableView.dataCollection = self.dataCollection;
        SchoolEditTableView.managedObjectContext = self.managedObjectContext;
        SchoolEditTableView.schoolInfo = selectedObject;
    }
    else if ([segue.identifier isEqualToString:@"segueHomePageCreateSchool"])
    {
        SchoolEditTableView *SchoolEditTableView = [segue destinationViewController];
        
        SchoolEditTableView.setEditStatus = @"Create";
        SchoolEditTableView.userInfo = self.userInfo;
        SchoolEditTableView.dataCollection = self.dataCollection;
        SchoolEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueHomePageCreateSemester"])
    {
        SemesterEditTableView *SemesterEditTableView = [segue destinationViewController];
        
        SemesterEditTableView.setEditStatus = @"Create";
        SemesterEditTableView.userInfo = self.userInfo;
        SemesterEditTableView.schoolDetails = [self.schoolList objectAtIndex:self.pageControl.currentPage];
        SemesterEditTableView.dataCollection = self.dataCollection;
        SemesterEditTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segueHomePageCreateCourse"])
    {
        SchoolDetails *selectedObject = [self.schoolList objectAtIndex:self.pageControl.currentPage];
        NSArray *semesterList = [self.dataCollection retrieveSemesterList:selectedObject context:self.managedObjectContext];
        SemesterDetails *currSemester = [semesterList objectAtIndex:0];
        
        CourseEditTableView *CourseEditTableView = [segue destinationViewController];
        
        CourseEditTableView.setEditStatus = @"Create";
        //CourseEditTableView.userInfo = self.userInfo;
        CourseEditTableView.semesterDetails = currSemester;
        CourseEditTableView.dataCollection = self.dataCollection;
        CourseEditTableView.managedObjectContext = self.managedObjectContext;
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(IBAction)Logout:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePageLogout" sender: self];
}

-(IBAction)EditProfile:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePageEditProfile" sender: self];
}

-(IBAction)BtnNextPage:(id)sender
{
    [self nextPage];
}

-(IBAction)BtnPreviousPage:(id)sender
{
    [self previousPage];
}

-(IBAction)BtnAddSchool:(id)sender
{
    if (self.displayType == (NSString *)@"Schools")
    {
        [self performSegueWithIdentifier: @"segueHomePageCreateSchool" sender: self];
    }
    else if (self.displayType == (NSString *)@"Semesters")
    {
        [self performSegueWithIdentifier: @"segueHomePageCreateSemester" sender: self];
    }
    else if (self.displayType == (NSString *)@"Courses")
    {
        NSArray *semesterList = [self.dataCollection retrieveSemesterList:[self.schoolList objectAtIndex:self.pageControl.currentPage] context:self.managedObjectContext];
        if ([semesterList count] == 0)
            [self performSegueWithIdentifier: @"segueHomePageCreateSemester" sender: self];
        else
            [self performSegueWithIdentifier: @"segueHomePageCreateCourse" sender: self];
    }
}

-(IBAction)BtnEditSchool:(id)sender
{
    if (buttonEditSchool.currentTitle == (NSString *)@"Edit")
    {
        if (self.displayType == (NSString *)@"Schools")
        {
            [self performSegueWithIdentifier: @"segueHomePageEditSchool" sender: self];
        }
        else if (self.displayType == (NSString *)@"Semesters")
        {
            SemesterTableView *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
            [sender setTitle:@"Done" forState:UIControlStateNormal];
            [newViewController setEditing:YES animated:YES];
        }
        else if (self.displayType == (NSString *)@"Courses")
        {
            SemesterTableView *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
            [sender setTitle:@"Done" forState:UIControlStateNormal];
            [newViewController setEditing:YES animated:YES];
        }
    }
    else
    {
        SemesterTableView *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [newViewController setEditing:NO animated:YES];
    }
}

- (void)viewDidUnload {
    [self setButtonLogout:nil];
    [self setButtonEditProfile:nil];
    [self setButtonNext:nil];
    [self setButtonPrevious:nil];
    [self setButtonAddSchool:nil];
    [self setButtonEditSchool:nil];
    [self setButtonSemesterList:nil];
    [self setButtonSchoolList:nil];
    [super viewDidUnload];
}

@end
