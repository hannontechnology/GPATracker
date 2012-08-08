//
//  HomePageViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-07.
//
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HomePageViewController : UIViewController

-(IBAction)schoolList:(id)sender;
-(IBAction)semesterList:(id)sender;
-(IBAction)courseList:(id)sender;
-(IBAction)profile:(id)sender;
-(IBAction)logout:(id)sender;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
