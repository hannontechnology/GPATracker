//
//  SchoolSummaryViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-11-18.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolDetails+Create.h"

@class DataCollection;

@interface SchoolSummaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *schoolCode;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *schoolYears;
@property (weak, nonatomic) IBOutlet UILabel *cGPA;
@property (weak, nonatomic) IBOutlet UILabel *semesterCount;
@property (weak, nonatomic) IBOutlet UILabel *courseCount;
@property (weak, nonatomic) IBOutlet UILabel *creditHours;
@property (weak, nonatomic) IBOutlet UILabel *totalSemesterCount;
@property (weak, nonatomic) IBOutlet UILabel *totalCourseCount;
@property (weak, nonatomic) IBOutlet UILabel *totalCreditHours;
@property (weak, nonatomic) IBOutlet UILabel *desiredGPA;
@property (weak, nonatomic) IBOutlet UILabel *calculatedGPA;

@property (strong, nonatomic) SchoolDetails *schoolInfo;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)DisplayInfo;

@end
