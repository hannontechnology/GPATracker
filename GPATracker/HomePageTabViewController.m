//
//  HomePageTabViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//
//

#import "HomePageTabViewController.h"
#import "SchoolSummaryViewController.h"
#import "SemesterListView.h"
#import "DataCollection.h"
#import "User+Create.h"
#import "LoginView.h"
#import "ProfileEditTableView.h"

@interface HomePageTabViewController ()
@end

@implementation HomePageTabViewController
@synthesize buttonLogout;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];

    for (SchoolDetails *item in self.schoolList)
    {
        SchoolSummaryViewController *View = [self.storyboard instantiateViewControllerWithIdentifier:@"SchoolSummaryView"];
        
        [View DisplaySchool:item];
 
        [self addChildViewController:View];
    }   
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	SchoolSummaryViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	[newViewController DisplaySchool:[self.schoolList objectAtIndex:self.pageControl.currentPage]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
}

-(IBAction)Logout:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePageLogout" sender: self];
}

-(IBAction)EditProfile:(id)sender
{
    [self performSegueWithIdentifier: @"segueHomePageEditProfile" sender: self];
}

- (void)viewDidUnload {
    [self setButtonLogout:nil];
    [super viewDidUnload];
}

@end

/*
@synthesize userInfo = _userInfo;
@synthesize pageControl = _pageControl;
@synthesize scrollView = _scrollView;
@synthesize segmentedControl = _segmentedControl;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

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
    [self setupSchoolSummaryPage];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (IBAction)ChangeDisplay:(id)sender
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [self setupSchoolSummaryPage];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        [self setupSemesterListPage];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2)
    {
        [self setupCourseListPage];
    }
}

- (void)setupSchoolSummaryPage
{
    if(self.scrollView!=nil)
    {
        while ([self.scrollView.subviews count] > 0) {
            //NSLog(@"subviews Count=%d",[[myScrollView subviews]count]);
            [[[self.scrollView subviews] objectAtIndex:0] removeFromSuperview];
        }
    }
	self.scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[self.scrollView setCanCancelContentTouches:NO];
	
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	self.scrollView.pagingEnabled = YES;

	NSUInteger niPages = 0;
	CGFloat cx = 0;
    NSArray *schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    for (SchoolDetails *item in schoolList)
    {
        SchoolSummaryView *schoolView = [[[NSBundle mainBundle] loadNibNamed:@"SchoolSummaryView" owner:self options:nil] objectAtIndex:0];
		if (schoolView == nil) {
			break;
		}
        
        schoolView.schoolInfo = item;
        [schoolView DisplaySchool:item];

 		CGRect rect = schoolView.frame;
		rect.size.height = 380;
		rect.size.width = 320;
		rect.origin.x = ((scrollView.frame.size.width)) + cx;
		rect.origin.y = ((scrollView.frame.size.height));
        
		schoolView.frame = rect;
       
		[self.scrollView addSubview:schoolView];
        
		cx += self.scrollView.frame.size.width;
        niPages++;
    }

	self.pageControl.numberOfPages = [self.userInfo.schoolDetails count];
	[self.scrollView setContentSize:CGSizeMake(cx, [self.scrollView bounds].size.height)];
}

- (void)setupSemesterListPage
{
    if(self.scrollView!=nil)
    {
        while ([self.scrollView.subviews count] > 0) {
            //NSLog(@"subviews Count=%d",[[myScrollView subviews]count]);
            [[[self.scrollView subviews] objectAtIndex:0] removeFromSuperview];
        }
    }
	self.scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[self.scrollView setCanCancelContentTouches:NO];
	
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	self.scrollView.pagingEnabled = YES;
    
	NSUInteger niPages = 0;
	CGFloat cx = 0;
    NSArray *schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    for (SchoolDetails *item in schoolList)
    {
        SemesterListView *semesterListView = [[[NSBundle mainBundle] loadNibNamed:@"SemesterListView" owner:self options:nil] objectAtIndex:0];
		if (semesterListView == nil) {
			break;
		}
        
        semesterListView.schoolInfo = item;
        [semesterListView DisplaySemesters:item];
        
 		CGRect rect = semesterListView.frame;
		rect.size.height = 380;
		rect.size.width = 320;
		rect.origin.x = ((scrollView.frame.size.width)) + cx;
		rect.origin.y = ((scrollView.frame.size.height));
        
		semesterListView.frame = rect;
        
		[self.scrollView addSubview:semesterListView];
        
		cx += self.scrollView.frame.size.width;
        niPages++;
    }
    
	self.pageControl.numberOfPages = [self.userInfo.schoolDetails count];
	[self.scrollView setContentSize:CGSizeMake(cx, [self.scrollView bounds].size.height)];
}

- (void)setupCourseListPage
{
    if(self.scrollView!=nil)
    {
        while ([self.scrollView.subviews count] > 0) {
            //NSLog(@"subviews Count=%d",[[myScrollView subviews]count]);
            [[[self.scrollView subviews] objectAtIndex:0] removeFromSuperview];
        }
    }
	self.scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[self.scrollView setCanCancelContentTouches:NO];
	
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	self.scrollView.pagingEnabled = YES;
    
	NSUInteger niPages = 0;
	CGFloat cx = 0;
    NSArray *schoolList = [self.dataCollection retrieveSchoolList:self.userInfo context:self.managedObjectContext];
    for (SchoolDetails *item in schoolList)
    {
        SchoolSummaryView *schoolView = [[[NSBundle mainBundle] loadNibNamed:@"SchoolSummaryView" owner:self options:nil] objectAtIndex:0];
		if (schoolView == nil) {
			break;
		}
        
        schoolView.schoolInfo = item;
        [schoolView DisplaySchool:item];
        
 		CGRect rect = schoolView.frame;
		rect.size.height = 380;
		rect.size.width = 320;
		rect.origin.x = ((scrollView.frame.size.width)) + cx;
		rect.origin.y = ((scrollView.frame.size.height));
        
		schoolView.frame = rect;
        
		[self.scrollView addSubview:schoolView];
        
		cx += self.scrollView.frame.size.width;
        niPages++;
    }
    
	self.pageControl.numberOfPages = [self.userInfo.schoolDetails count];
	[self.scrollView setContentSize:CGSizeMake(cx, [self.scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    pageControlIsChangingPage = NO;
}

- (IBAction)changePage:(id)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
	
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlIsChangingPage = YES;
}

@end
*/