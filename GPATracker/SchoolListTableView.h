//
//  HomePageTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class User;
@class DataCollection;

@interface SchoolListTableView : CoreDataTableViewController
{
    IBOutlet UIAlertView *alert;
}
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString *showEdit;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

@end
