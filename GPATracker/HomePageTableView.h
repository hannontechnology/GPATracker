//
//  HomePageTableView.h
//  GPATracker
//
//  Created by terryah on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageTableView : UITableViewController
{
    NSArray *schoolList;
}
@property (strong, retain) NSArray *schoolList;
@property (strong, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UITableView *homePageTableView;

@end
