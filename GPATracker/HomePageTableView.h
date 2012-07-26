//
//  HomePageTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HomePageTableView : UITableViewController
{
    IBOutlet UIAlertView *alert;
}
@property (strong, nonatomic) NSArray *schoolList;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

@end
