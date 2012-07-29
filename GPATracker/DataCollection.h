//
//  DataCollection.h
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SchoolDetails;
@class User;

@interface DataCollection : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// User Section
- (NSArray *)retrieveUsers:(NSString *)inputUserName userPassword:(NSString *) inputUserPassword inContext:(NSManagedObjectContext *) inputContext;
- (NSArray *)retrieveUsers:(NSString *)inputUserName inContext:(NSManagedObjectContext *) inputContext;
- (NSArray *)retrieveAutoLogin:(NSManagedObjectContext *) inputContext;

// School Section
- (NSArray *)retrieveSchools:(NSString *)inputSchoolName user:(User *)inputUser context:(NSManagedObjectContext *)inContext;

// Grading Scheme Section
- (NSArray *)retrieveGradingScheme:(NSString *)inputGradingScheme schoolName:(NSString *)inputSchoolName;

// Semester Section
- (NSArray *)retrieveSemester:(NSString *)inputSemesterName schoolDetails:(SchoolDetails *)inputSchoolDetails  context:(NSManagedObjectContext *) inContext;

// Course Section

// Miscellaneous Functions
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
