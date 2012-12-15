//
//  HomePageTabViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"

@class User;
@class DataCollection;

@interface HomePageTabViewController : PagerViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonLogout;

@property (strong, nonatomic) NSString *showEdit;

-(IBAction)Logout:(id)sender;
-(IBAction)EditProfile:(id)sender;

/*@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) User *userInfo;

<UIScrollViewDelegate>
{
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	
    BOOL pageControlIsChangingPage;
}

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) User *userInfo;

- (IBAction)changePage:(id)sender;
- (IBAction)ChangeDisplay:(id)sender;
- (void)setupSchoolSummaryPage;
- (void)setupSemesterListPage;
- (void)setupCourseListPage;
*/
@end
