//
//  User+Create.h
//  GPATracker
//
//  Created by terryah on 12-07-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@interface User (Create)
+ (User *)addUser:(User *)user context:(NSManagedObjectContext *)inContext;
@end
