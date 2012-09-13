//
//  HomePageTabViewController.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//
//

#import "HomePageTabViewController.h"

@interface HomePageTabViewController ()

@end

@implementation HomePageTabViewController
@synthesize pageView;
@synthesize pageControl;
@synthesize tabBar;
@synthesize infoControl;

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
    [self setPageView:nil];
    [self setPageControl:nil];
    [self setTabBar:nil];
    [self setInfoControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
