//
//  SchoolEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataCollection;
@class User;
@class SchoolDetails;
@class GradingSchemeSelectTableView;
@class GradingSchemeTableView;
@class GradingScheme;

@interface SchoolEditTableView : UITableViewController <UIActionSheetDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) GradingScheme *gradingInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSString *setInputType;
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
@property (weak, nonatomic) IBOutlet UITextField *schoolDetailsField;
@property (weak, nonatomic) IBOutlet UITextField *schoolStartYearField;
@property (weak, nonatomic) IBOutlet UITextField *schoolEndYearField;
@property (weak, nonatomic) IBOutlet UITextField *historicalGPAField;
@property (weak, nonatomic) IBOutlet UITextField *historicalCreditsField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

@property (strong, nonatomic) NSString *setEditStatus;

@property (weak, nonatomic) IBOutlet UILabel *gradingScheme;



@end
