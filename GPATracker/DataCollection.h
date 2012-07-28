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

@interface DataCollection : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, copy) NSArray *masterUserList;
@property (nonatomic, copy) NSArray *masterSchoolList;

// School Section
- (NSArray *)retrieveSchools:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (NSArray *)retrieveSchools:(NSString *)inputSchoolName;
- (NSArray *)retrieveSchoolList:(NSString *)inputUserName;
- (NSArray *)retrieveSchools;
- (int)addSchool:(NSString *)inputSchoolName schoolDetail:(NSString *)inputSchoolDetail schoolStartYear:(NSString *)inputSchoolStartYear schoolEndYear:(NSString *)inputSchoolEndYear userName:(NSString *)inputUserName;
- (int)updateSchool:(NSArray *)inputSchool;
- (int)deleteSchool:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (int)deleteSchool:(NSManagedObject *)inputSchool;
- (NSUInteger)countOfSchoolList;

// Grading Scheme Section
//- (NSArray *)retrieveGradingScheme:(NSString *)
//- (int)addGradingScheme:(

// Semester Section
- (NSArray *)retrieveSemesterList:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (NSArray *)retrieveSemester:(NSString *)inputSemesterName schoolName:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (int)addSemester:(NSString *)inputSemesterName semesterYear:(NSNumber *)inputSemesterYear semesterCode:(NSNumber *)inputSemesterCode userName:(NSString *)inputUserName schoolName:(NSString *)inputSchoolName;
- (int)updateSemester:(NSArray *)inputSemester;
- (int)deleteSemester:(NSManagedObject *)inputSemester;

// Course Section
- (NSArray *)retrieveCourses:(NSString *)inputSemesterName schoolName:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (NSArray *)retrieveCourses:(NSString *)inputSchoolName semesterName:(NSString *)inputSemesterName schoolName:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (int)addCourse:(NSString *)inputCourseCode semesterName:(NSString *)inputSemesterName semesterName:(NSString *)inputSemesterName schoolName:(NSString *)inputSchoolName userName:(NSString *)inputUserName;
- (int)updateCourse:(NSArray *)inputSchool;
- (int)deleteCourse:(NSManagedObject *)inputCourse;

// Miscellaneous Functions
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
