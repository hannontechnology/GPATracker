//
//  DataCollection.h
//  GPATracker
//
//  Created by terryah on 12-05-22.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface DataCollection : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, copy) NSArray *masterUserList;

- (NSArray *)retrieveUsers:(NSString *)inputUserName userPassword:(NSString *) inputUserPassword; 
- (NSArray *)retrieveUsers:(NSString *)inputUserName; 
- (NSArray *)retrieveUsers;
- (NSArray *)retrieveAutoLogin;
- (void)removeAutoLogin;
- (void)setAutoLogin:(NSString *)inputUserName; 
- (int)addUser:(NSString *)inputUserName userPassword:(NSString *)inputUserPassword userFirstName:(NSString *)inputUserFirstName userLastName:(NSString *)inputUserLastName userEmail:(NSString *)inputUserEmail autoLogin:(NSNumber *)inputAutoLogin;
- (NSUInteger)countOfUserList;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
