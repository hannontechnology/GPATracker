//
//  CourseTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class SemesterDetails;
@class DataCollection;

@interface CourseTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) SemesterDetails *semesterInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *semesterNameText;
@property (weak, nonatomic) IBOutlet UILabel *semesterCourseCount;
@property (weak, nonatomic) IBOutlet UILabel *semesterCreditHours;
@property (weak, nonatomic) IBOutlet UILabel *semesterGPA;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
-(IBAction)back;

@end
