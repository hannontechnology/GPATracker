//
//  HomePage.h
//  GPATracker
//
//  Created by terryah on 12-03-18.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageView : UIViewController
{
    NSArray *schoolList;
}
@property (strong, retain) NSArray *schoolList;
@property (strong, nonatomic) NSString *userName;
@property (retain, nonatomic) IBOutlet UILabel *schoolTitle;
@property (retain, nonatomic) IBOutlet UILabel *schoolSubTitle;
@property (retain, nonatomic) IBOutlet UITableView *homePageTableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *homePageCell;
- (IBAction)EditSchool:(id)sender;
- (IBAction)AddSchool:(id)sender;

@end
