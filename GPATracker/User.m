//
//  User.m
//  GPATracker
//
//  Created by terryah on 12-05-17.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize emailAddress = _emailAddress, password = _password, autoLogin = _autoLogin, userFirstName = _userFirstName, userLastName = _userLastName;

-(id)initWithName:(NSString *)emailAddress password:(NSString *)password autoLogin:(NSString *)autoLogin userFirstName:(NSString *)userFirstName userLastName:(NSString *)userLastName
{
    self = [super init];
    if (self)
    {
        _emailAddress = emailAddress;
        _password = password;
        _autoLogin = autoLogin;
        _userFirstName = userFirstName;
        _userLastName = userLastName;
        
        return self;        
    }
    return nil;
}
@end
