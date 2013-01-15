//
//  User+Create.m
//  GPATracker
//
//  Created by Terry Hannon on 12-07-27.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)
- (User *)addUser:(User *)user context:(NSManagedObjectContext *)inContext
{
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@", user.userName];
    NSLog(@"filtering data based on userName = %@", user.userName);
    NSError *error = nil;
    NSArray *results = [inContext executeFetchRequest:request error:&error];
    if ([results count] != 0)
    {
        NSLog(@"Whoops, couldn't save: UserName already exists");
        return nil;
    }
    
    User *newUser = [NSEntityDescription
                     insertNewObjectForEntityForName:entityName
                     inManagedObjectContext:inContext];
    newUser.userName = user.userName;
    newUser.userFirstName = user.userFirstName;
    newUser.userLastName = user.userLastName;
    newUser.userEmail = user.userEmail;
    newUser.userPassword = user.userPassword;
    newUser.autoLogon = user.autoLogon;

    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    else
    {
        NSLog(@"Save was successful");
        if (newUser.autoLogon == [NSNumber numberWithInt:1])
        {
            //[self.dataCollection removeAutoLogin];
            //[self.dataCollection setAutoLogin:userNameField.text];
        }
    }
    return newUser;
}

- (void)removeAutoLogin:(User *)user context:(NSManagedObjectContext *)inContext
{
    int count = 0;
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"autoLogon = 1"];
    NSLog(@"filtering data based on autoLogon = 1");
    
    NSError *error = nil;
    NSArray *results = [inContext executeFetchRequest:request error:&error];
    
    for (User *item in results) {
        if (item.autoLogon == [NSNumber numberWithInt:1] && !(item.userName == user.userName))
        {
            item.autoLogon = [NSNumber numberWithInt:0];
            count++;
        }
        else if (item.userName == user.userName)
        {
            item.autoLogon = [NSNumber numberWithInt:1];
            count++;
        }
    }
    if (count > 0)
    {
        if (![inContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (void)setAutoLogin:(User *)user context:(NSManagedObjectContext *)inContext
{
    NSError *error = nil;

    user.autoLogon = [NSNumber numberWithInt:1];

    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
