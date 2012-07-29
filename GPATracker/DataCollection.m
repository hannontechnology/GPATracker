//
//  DataCollection.m
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "DataCollection.h"
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

//Code for handling user information
- (NSArray *)retrieveUsers:(NSString *)inputUserName userPassword:(NSString *) inputUserPassword inContext:(NSManagedObjectContext *) inputContext
{
    NSString *entityName = @"User"; // Put your entity name here
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@ and userPassword = %@", inputUserName, inputUserPassword];
    
    NSError *error = nil;
    NSArray *results = [inputContext executeFetchRequest:request error:&error];
    return results;
}

- (NSArray *)retrieveUsers:(NSString *)inputUserName inContext:(NSManagedObjectContext *) inputContext
{
    NSString *entityName = @"User"; // Put your entity name here
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@", inputUserName];
    
    NSError *error = nil;
    NSArray *results = [inputContext executeFetchRequest:request error:&error];
    return results;
}

- (NSArray *)retrieveAutoLogin:(NSManagedObjectContext *) inputContext
{
    NSString *entityName = @"User"; // Put your entity name here
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"autoLogon = 1"];
    
    NSError *error = nil;
    NSArray *results = [inputContext executeFetchRequest:request error:&error];
    return results;
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

- (NSArray *)retrieveGradingScheme:(NSString *)inputGradingScheme schoolName:(NSString *)inputSchoolName
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSString *entityName = @"GradingScheme";
    NSLog(@"Setting up a Fetched Results Contraoller for the Entity name %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"schoolName = %@",inputSchoolName];
    NSLog(@"filtering data based on schoolName = %@",inputSchoolName);
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
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

- (NSArray *)retrieveSemester:(NSString *)inputSemesterName schoolDetails:(SchoolDetails *)inputSchoolDetails context:(NSManagedObjectContext *) inContext
{
    NSString *entityName = @"SemesterDetails";
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat: @"schoolDetails = %@ AND semesterName = %@", inputSchoolDetails, inputSemesterName];
    
    NSError *error = nil;
    NSArray*results = [inContext executeFetchRequest:request error:& error];
    return results;
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

//Core Data Required Functions
- (id)init {
    if (self = [super init]) {
        return self;
    }
    return nil;
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

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
