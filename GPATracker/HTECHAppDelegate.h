//
//  HTECHAppDelegate.h
//  GPATracker
//
//  Created by terryah on 12-03-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class DataCollection;

@interface HTECHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) DataCollection *dataCollection;

@end
