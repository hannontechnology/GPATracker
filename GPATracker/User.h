//
//  User.h
//  GPATracker
//
//  Created by terryah on 12-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SchoolDetails;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * autoLogon;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userFirstName;
@property (nonatomic, retain) NSString * userLastName;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPassword;
@property (nonatomic, retain) NSSet *schools;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addSchoolsObject:(SchoolDetails *)value;
- (void)removeSchoolsObject:(SchoolDetails *)value;
- (void)addSchools:(NSSet *)values;
- (void)removeSchools:(NSSet *)values;

@end
