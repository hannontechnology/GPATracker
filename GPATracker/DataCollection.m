//
//  DataCollection.m
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "DataCollection.h"
#import "User.h"

@interface DataCollection ()
- (void)initializeDefaultDataList;
@end

@implementation DataCollection
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize masterUserList = _masterUserList;

- (void)initializeDefaultDataList {
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSError *error = nil;
    self.masterUserList = [moc executeFetchRequest:request error:&error];
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (NSUInteger)countOfUserList {
    return [self.masterUserList count];
}

- (User *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterUserList objectAtIndex:theIndex];    
}

- (NSArray *)retrieveUsers:(NSString *)inputUserName userPassword:(NSString *) inputUserPassword
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@ and userPassword = %@", inputUserName, inputUserPassword];
    NSLog(@"filtering data based on userName = %@ and userPassword = %@", inputUserName, inputUserPassword);
    
    NSError *error = nil;
    self.masterUserList = [moc executeFetchRequest:request error:&error];
    return self.masterUserList;
}

- (NSArray *)retrieveUsers:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@", inputUserName];
    NSLog(@"filtering data based on userName = %@", inputUserName);
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    return results;
}

- (NSArray *)retrieveUsers
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    return results;
}

- (NSArray *)retrieveAutoLogin
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"autoLogon = 1"];
    NSLog(@"filtering data based on autoLogon = 1");
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    return results;
}

- (void)removeAutoLogin
{
    int count = 0;
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"autoLogon = 1"];
    NSLog(@"filtering data based on autoLogon = 1");
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    for (User *item in results) {
        if (item.autoLogon == [NSNumber numberWithInt:1])
        {
            item.autoLogon = [NSNumber numberWithInt:0];
            count++;
        }
    }
    if (count > 0)
    {
        if (![moc save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (void)setAutoLogin:(NSString *)inputUserName
{
    int count = 0;
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@", inputUserName];
    NSLog(@"filtering data based on userName = %@", inputUserName);
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    for (User *item in results) {
        item.autoLogon = [NSNumber numberWithInt:1];
        count++;
    }
    if (count > 0)
    {
        if (![moc save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
}

- (int)addUser:(NSString *)inputUserName userPassword:(NSString *)inputUserPassword userFirstName:(NSString *)inputUserFirstName userLastName:(NSString *)inputUserLastName userEmail:(NSString *)inputUserEmail autoLogin:(NSNumber *)inputAutoLogin
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"User"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);

    User *newUser = [NSEntityDescription
                     insertNewObjectForEntityForName:entityName
                     inManagedObjectContext:moc];
    newUser.userName = inputUserName;
    newUser.userPassword = inputUserPassword;
    newUser.userFirstName = inputUserFirstName;
    newUser.userLastName = inputUserLastName;
    newUser.userEmail = inputUserEmail;
    newUser.autoLogon = inputAutoLogin;
    NSError *error;
    if (![moc save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return -1;
    }
    return 0;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GPATracker" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GPATracker.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
