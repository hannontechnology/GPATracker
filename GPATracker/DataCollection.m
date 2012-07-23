//
//  DataCollection.m
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "DataCollection.h"
#import "User.h"
#import "SchoolDetails.h"
#import "gradingScheme.h"
#import "SemesterDetails.h"

@interface DataCollection ()
- (void)initializeDefaultDataList;
@end

@implementation DataCollection
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize masterUserList = _masterUserList;
@synthesize masterSchoolList = _masterSchoolList;

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

//Code for handling User information
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
    
    for (User *item in results)
    {
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

- (int)updateUser:(NSArray *)inputUser
{
    for (User *item in inputUser)
    {
        NSManagedObjectContext *moc = [self managedObjectContext];
        
        NSString *entityName = @"User"; // Put your entity name here
        NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        NSError *error = nil;
        NSArray *results = [moc executeFetchRequest:request error:&error];
        
        if ([results count] > 0)
        {
            results = inputUser;
        }

        if (![moc save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return -1;
        }
    }
    return 0;
}

//Code for handling school information
- (NSArray *)retrieveSchools:(NSString *)inputSchoolName userName:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SchoolDetails";
    NSLog(@"Seeting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat: @"schoolName = %@ AND userName = %@", inputSchoolName, inputUserName];
    NSLog(@"filtering data based on schoolName = %@", inputSchoolName);
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:& error];
    return results;
}

- (NSArray *)retrieveSchoolList:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SchoolDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat: @"userName = %@", inputUserName];
    NSLog(@"filtering data based on userName = %@", inputUserName);
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:& error];
    return results;
}

- (NSArray *)retrieveSemesterList:(NSString *)inputSchoolName userName:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SemesterDetails";
    NSLog(@"Setting up Fetched Results Controller for Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat: @"userName = %@ AND schoolName = %@", inputUserName, inputSchoolName];
    
    NSLog(@"Filtering data based on userName = %@ AND schoolName = %@", inputUserName, inputSchoolName);
    
    NSError *error = nil;
    NSArray*results = [moc executeFetchRequest:request error:& error];
    return results;
}

- (NSArray *)retrieveSemester:(NSString *)inputSemesterName schoolName:(NSString *)inputSchoolName userName:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SemesterDetails";
    NSLog(@"Setting up Fetched Results Controller for Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat: @"userName = %@ AND schoolName = %@ AND semesterName = %@", inputUserName, inputSchoolName, inputSemesterName];
    
    NSLog(@"Filtering data based on userName = %@ AND schoolName = %@ AND semesterName = %@", inputUserName, inputSchoolName, inputSemesterName);
    
    NSError *error = nil;
    NSArray*results = [moc executeFetchRequest:request error:& error];
    return results;
}

- (int)addSemester:(NSString *)inputSemesterName semesterYear:(NSNumber *)inputSemesterYear semesterCode:(NSNumber *)inputSemesterCode userName:(NSString *)inputUserName schoolName:(NSString *)inputSchoolName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SemesterDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    SemesterDetails *newSemester = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc];
    newSemester.semesterName = inputSemesterName;
    newSemester.semesterYear = inputSemesterYear;
    newSemester.semesterCode = inputSemesterCode;
    newSemester.userName = inputUserName;
    newSemester.schoolName = inputSchoolName;
    
    NSError *error;
    if(![moc save:&error])
    {
        NSLog(@"Hot Damn, couldn't save: %@", [error localizedDescription]);
        return -1;
    }
    return 0;
}

- (int)updateSemester:(NSArray *)inputSemester
{
    for(SemesterDetails *item in inputSemester)
    {
        NSManagedObjectContext *moc = [self managedObjectContext];
        
        NSString *entityName = @"SemesterDetails";
        NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        request.predicate = [NSPredicate predicateWithFormat: @"userName = %@ AND schoolName = %@ AND semesterName = %@", item.userName, item.schoolName, item.semesterName];
        
        NSError *error = nil;
        NSArray *results = [moc executeFetchRequest:request error:&error];
        
        if([results count] > 0)
        {
            results = inputSemester;
        }
        
        if(![moc save:&error])
        {
            NSLog(@"Couldn't save: %@", [error localizedDescription]);
            return -1;
        }
    }
    return 0;
}

- (int)deleteSemester:(NSManagedObject *)inputSemester
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    [moc deleteObject:inputSemester];
    
    NSError *error = nil;
    if(![moc save:&error])
    {
        NSLog(@"Delete semester failed: %@", [error localizedDescription]);
        return -1;
    }
    NSLog(@"Delete semester successful!");
    return 0;
}

- (int)addSchool:(NSString *)inputSchoolName schoolDetail:(NSString *)inputSchoolDetail schoolStartYear:(NSString *)inputSchoolStartYear schoolEndYear:(NSString *)inputSchoolEndYear userName:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SchoolDetails";
    NSLog(@"Setting upa Fetched Results Controller for the Entity named %@", entityName);
    
    SchoolDetails *newSchool = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc];
    newSchool.schoolName = inputSchoolName;
    newSchool.schoolDetails = inputSchoolDetail;
    newSchool.schoolStartYear = inputSchoolStartYear;
    newSchool.schoolEndYear = inputSchoolEndYear;
    newSchool.userName = inputUserName;
    
    int temp1 = arc4random()%433;
    double temp2 = (double)temp1/100;
    NSDecimalNumber *temp3 = [[NSDecimalNumber alloc]initWithDouble:(temp2)];
    NSDecimalNumber *temp4 = [[NSDecimalNumber alloc]initWithDouble:(0.00)];
    
    newSchool.schoolActualGPA = temp3;
    newSchool.schoolCalculatedGPA = temp4;
    
    // Missing for grading scheme
    NSError *error;
    if (![moc save:&error])
    {
        NSLog(@"Hot Damn, couldn't save: %@", [error localizedDescription]);
        return -1;
    }
    return 0;
}

- (int)deleteSchool:(NSString *)inputSchoolName userName:(NSString *)inputUserName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"SchoolDetails";
    NSLog(@"Seeting up a Fetched Results Controller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat: @"userName = %@ AND schoolName = %@", inputUserName, inputSchoolName];
    NSLog(@"filtering data based on userName = %@ AND schoolName = %@", inputUserName, inputSchoolName);
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:& error];

    for (id item in results)
    {
        [moc deleteObject:item];
    }

    if (![moc save:&error])
    {
        NSLog(@"Hot Damn, couldn't save: %@", [error localizedDescription]);
        return -1;
    }
    NSLog(@"Delete Successful!");
    return 0;
}

- (int)deleteSchool:(NSManagedObject *)inputSchool
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    [moc deleteObject:inputSchool];
    
    NSError *error = nil;
    if (![moc save:&error])
    {
        NSLog(@"Hot Damn, couldn't save: %@", [error localizedDescription]);
        return -1;
    }
    NSLog(@"Delete Successful!");
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
