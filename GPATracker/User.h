//
//  User.h
//  GPATracker
//
//  Created by terryah on 12-05-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userFirstName;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * userLastName;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPassword;

@end
