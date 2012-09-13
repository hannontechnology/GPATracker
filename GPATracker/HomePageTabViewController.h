//
//  HomePageTabViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HomePageTabViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *infoControl;

@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
