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

@property (weak, nonatomic) IBOutlet UILabel *schoolNameText;
@property (weak, nonatomic) IBOutlet UILabel *schoolDescText;
@property (weak, nonatomic) IBOutlet UILabel *schoolYearsText;
@property (weak, nonatomic) IBOutlet UILabel *schoolCGPAText;

-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
-(IBAction)back;

-(void)DisplayInfo;

@end
