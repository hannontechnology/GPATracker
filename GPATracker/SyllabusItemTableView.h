//
//  SyllabusTableView.h
//  GPATracker
//
//  Created by David Stevens on 13-03-24.
//
//
#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class SyllabusDetails;
@class DataCollection;

@interface SyllabusItemTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) SyllabusDetails *syllabusDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *sectionNameField;
@property (weak, nonatomic) IBOutlet UILabel *sectionWeightField;
@property (weak, nonatomic) IBOutlet UILabel *sectionGradeField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnHomePage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSemesterList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCourseList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCalendar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;


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
