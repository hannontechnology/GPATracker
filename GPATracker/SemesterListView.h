//
//  SemesterListView.h
//  GPATracker
//
//  Created by Terry Hannon on 12-09-26.
//
//

#import <UIKit/UIKit.h>

@class SchoolDetails;

@interface SemesterListView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) SchoolDetails *schoolInfo;

-(void)DisplaySemesters:(SchoolDetails *)inSchool;

@end
