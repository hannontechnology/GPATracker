//
//  CourseListTableView.h
//  GPATracker
//
//  Created by Terry Hannon on 13-02-08.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class SchoolDetails;
@class DataCollection;

@interface CourseListTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
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
