//
//  User+Create.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-27.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "User.h"

@interface User (Create)
- (User *)addUser:(User *)user context:(NSManagedObjectContext *)inContext;
- (void)removeAutoLogin:(User *)user context:(NSManagedObjectContext *)inContext;
- (void)setAutoLogin:(User *)user context:(NSManagedObjectContext *)inContext;
@end
