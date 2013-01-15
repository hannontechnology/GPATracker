//
//  HTECHAppDelegate.h
//  GPATracker
//
//  Created by Terry Hannon on 12-03-17.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HTECHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) DataCollection *dataCollection;

@end
