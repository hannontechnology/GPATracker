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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonEditProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonSemesterList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonSchoolList;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIButton *buttonPrevious;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddSchool;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditSchool;

-(IBAction)Logout:(id)sender;
-(IBAction)EditProfile:(id)sender;
-(IBAction)DisplaySchools:(id)sender;
-(IBAction)DisplaySemesters:(id)sender;
-(IBAction)BtnNextPage:(id)sender;
-(IBAction)BtnPreviousPage:(id)sender;
-(IBAction)BtnAddSchool:(id)sender;
-(IBAction)BtnEditSchool:(id)sender;

- (void)viewSchools;
- (void)viewSemesters;

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
