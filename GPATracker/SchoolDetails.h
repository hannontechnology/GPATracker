//
//  SchoolDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-01-04.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, SemesterDetails, User;

@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSNumber * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSNumber * schoolStartYear;
@property (nonatomic, retain) NSSet *gradingScheme;
@property (nonatomic, retain) NSSet *semesterDetails;
@property (nonatomic, retain) User *user;
@end

@interface SchoolDetails (CoreDataGeneratedAccessors)

- (void)addGradingSchemeObject:(GradingScheme *)value;
- (void)removeGradingSchemeObject:(GradingScheme *)value;
- (void)addGradingScheme:(NSSet *)values;
- (void)removeGradingScheme:(NSSet *)values;

- (void)addSemesterDetailsObject:(SemesterDetails *)value;
- (void)removeSemesterDetailsObject:(SemesterDetails *)value;
- (void)addSemesterDetails:(NSSet *)values;
- (void)removeSemesterDetails:(NSSet *)values;

@end
