//
//  User+Create.m
//  GPATracker
//
//  Created by terryah on 12-07-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)
+ (User *)addUser:(User *)user context:(NSManagedObjectContext *)inContext
{
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    User *newUser = [NSEntityDescription
                     insertNewObjectForEntityForName:entityName
                     inManagedObjectContext:inContext];
    newUser.userName = user.userName;
    newUser.userFirstName = user.userFirstName;
    newUser.userLastName = user.userLastName;
    newUser.userEmail = user.userEmail;
    newUser.userPassword = user.userPassword;
    newUser.autoLogon = user.autoLogon;
    NSError *error = nil;
    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    return newUser;
}

@end
