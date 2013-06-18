//
//  SyllabusListTableView.h
//  GPATracker
//
//  Created by David Stevens on 13-03-24.
//
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class CourseDetails;
@class DataCollection;

@interface SyllabusListTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) CourseDetails *courseDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *courseCodeText;
@property (weak, nonatomic) IBOutlet UILabel *courseNameText;
@property (weak, nonatomic) IBOutlet UILabel *courseDesiredGradeText;
@property (weak, nonatomic) IBOutlet UILabel *courseMinPercentText;
@property (weak, nonatomic) IBOutlet UILabel *courseMaxPercentText;
@property (weak, nonatomic) IBOutlet UILabel *courseCreditsText;
@property (weak, nonatomic) IBOutlet UILabel *courseTotalWeightText;
@property (weak, nonatomic) IBOutlet UILabel *courseCurrPercentText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnHomePage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSemesterList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCourseList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCalendar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;
@property (strong, nonatomic) NSString *viewType;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
-(IBAction)back;

-(void)DisplayInfo;
- (IBAction)GotoHomePage:(id)sender;
- (IBAction)GotoSemesterList:(id)sender;
- (IBAction)GotoCourseList:(id)sender;
- (IBAction)GotoCalendar:(id)sender;
- (IBAction)EditProfile:(id)sender;
- (IBAction)Logout:(id)sender;



@end

