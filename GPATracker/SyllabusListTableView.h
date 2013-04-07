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

@property (weak, nonatomic) IBOutlet UILabel *schoolNameText;
@property (weak, nonatomic) IBOutlet UILabel *schoolDescText;
@property (weak, nonatomic) IBOutlet UILabel *schoolYearsText;
@property (weak, nonatomic) IBOutlet UILabel *schoolCGPAText;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
-(IBAction)back;

-(void)DisplayInfo;

@end

