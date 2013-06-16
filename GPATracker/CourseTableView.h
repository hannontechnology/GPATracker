//
//  CourseTableView.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-22.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class SchoolDetails;
@class SemesterDetails;
@class DataCollection;

@interface CourseTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) SemesterDetails *semesterInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *semesterNameText;
@property (weak, nonatomic) IBOutlet UILabel *semesterCourseCount;
@property (weak, nonatomic) IBOutlet UILabel *semesterCreditHours;
@property (weak, nonatomic) IBOutlet UILabel *semesterGPA;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnHomePage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSemeserList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCourseList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCalendar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;
@property (strong, nonatomic) NSString *viewType;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

-(void)DisplayInfo;
-(IBAction)GotoHomePage:(id)sender;
-(IBAction)GotoSemesterList:(id)sender;
-(IBAction)GotoCourseList:(id)sender;
-(IBAction)GotoCalendar:(id)sender;
-(IBAction)EditProfile:(id)sender;
-(IBAction)Logout:(id)sender;

@end
