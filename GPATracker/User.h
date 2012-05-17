//
//  User.h
//  GPATracker
//
//  Created by terryah on 12-05-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : UIDocument
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *autoLogin;
@property (nonatomic, retain) NSString *userFirstName;
@property (nonatomic, retain) NSString *userLastName;

-(id)initWithName:(NSString *)emailAddress password:(NSString *)password autoLogin:(NSString *)autoLogin userFirstName:(NSString *)userFirstName userLastName:(NSString *)userLastName;
@end
