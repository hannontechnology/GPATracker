//
//  DataCollection.h
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class SchoolDetails;
@class SemesterDetails;

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
- (NSArray *)retrieveGradingScheme:(SchoolDetails *)inputSchool;
//- (NSArray *)retrieveGrades:(NSString *)inputGradingScheme;
- (NSArray *)retrieveGradingScheme:(NSString *)inputGradingScheme school:(SchoolDetails *)inputSchool;

// Semester Section
- (NSArray *)retrieveSemester:(NSString *)inputSemesterName semesterYear:(NSNumber *)inputSemesterYear schoolDetails:(SchoolDetails *)inputSchoolDetails context:(NSManagedObjectContext *) inContext;

// Course Section
- (NSArray *)retrieveCourse:(NSString *)inputCourseCode semesterDetails:(SemesterDetails *)inputSemesterDetails  context:(NSManagedObjectContext *) inContext;

// Retrieve Year List for picker
- (NSArray *)retrieveYearPicker:(NSManagedObjectContext *) inContext;

// Miscellaneous Functions
- (void)buildYearTable:(NSManagedObjectContext *) inputContext;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
