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

// User Section
- (NSArray *)retrieveUsers:(NSString *)inputUserName userPassword:(NSString *) inputUserPassword; 
- (NSArray *)retrieveUsers:(NSString *)inputUserName; 
- (NSArray *)retrieveUsers;
- (NSArray *)retrieveAutoLogin;
- (void)removeAutoLogin;
- (void)setAutoLogin:(NSString *)inputUserName; 
- (int)addUser:(NSString *)inputUserName userPassword:(NSString *)inputUserPassword userFirstName:(NSString *)inputUserFirstName userLastName:(NSString *)inputUserLastName userEmail:(NSString *)inputUserEmail autoLogin:(NSNumber *)inputAutoLogin;
- (int)updateUser:(NSArray *)inputUser;

- (NSUInteger)countOfUserList;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

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

// Course Section

@end
