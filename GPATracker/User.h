//
//  User.h
//  GPATracker
//
//  Created by David Stevens on 12-08-12.
//
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
@property (nonatomic, retain) NSSet *schoolDetails;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addSchoolDetailsObject:(SchoolDetails *)value;
- (void)removeSchoolDetailsObject:(SchoolDetails *)value;
- (void)addSchoolDetails:(NSSet *)values;
- (void)removeSchoolDetails:(NSSet *)values;

@end
