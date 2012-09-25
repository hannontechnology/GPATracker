//
//  HomePageTabViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//
//

#import "HomePageTabViewController.h"
#import "SchoolSummaryView.h"
#import "User+Create.h"

@interface HomePageTabViewController ()

@end

@implementation HomePageTabViewController
@synthesize userInfo = _userInfo;
@synthesize pageControl = _pageControl;
@synthesize scrollView = _scrollView;
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
    [self setupPage];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPageControl:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupPage
{
	self.scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[self.scrollView setCanCancelContentTouches:NO];
	
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	self.scrollView.pagingEnabled = YES;

	NSUInteger niPages = 0;
	CGFloat cx = 0;
    for (SchoolDetails *item in self.userInfo.schoolDetails)
    {
        SchoolSummaryView *schoolView = [[[NSBundle mainBundle] loadNibNamed:@"SchoolSummaryView" owner:self options:nil] objectAtIndex:0];
		if (schoolView == nil) {
			break;
		}
        
        schoolView.schoolInfo = item;
        [schoolView DisplaySchool:item];

 		CGRect rect = schoolView.frame;
		rect.size.height = 370;
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
    
	/*
	 *	We switch page at 50% across
	 */
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
	/*
	 *	Change the scroll view
	 */
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
	
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
}

@end
