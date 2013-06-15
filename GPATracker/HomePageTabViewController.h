//
//  HomePageTabViewController.h
//  GPATracker
//
//  Created by Terry Hannon on 12-09-10.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"

@class User;
@class DataCollection;

@interface HomePageTabViewController : PagerViewController <UIPickerViewDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonLogout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonEditProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCourseList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonSemesterList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonSchoolList;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIButton *buttonPrevious;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddSchool;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditSchool;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

-(IBAction)Logout:(id)sender;
-(IBAction)EditProfile:(id)sender;
-(IBAction)DisplaySchools:(id)sender;
-(IBAction)DisplaySemesters:(id)sender;
-(IBAction)DisplayCourses:(id)sender;
-(IBAction)BtnNextPage:(id)sender;
-(IBAction)BtnPreviousPage:(id)sender;
-(IBAction)BtnAddSchool:(id)sender;
-(IBAction)BtnEditSchool:(id)sender;

- (void)viewSchools;
- (void)viewSemesters;
- (void)viewCourses;
- (void)viewCalendar;
@end
