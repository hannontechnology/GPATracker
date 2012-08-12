//
//  SchoolDetails.h
//  GPATracker
//
//  Created by David Stevens on 12-08-12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, SemesterDetails, User;

@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * schoolActualGPA;
@property (nonatomic, retain) NSDecimalNumber * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSNumber * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSNumber * schoolStartYear;
@property (nonatomic, retain) GradingScheme *gradingScheme;
@property (nonatomic, retain) NSSet *semesterDetails;
@property (nonatomic, retain) User *user;
@end

@interface SchoolDetails (CoreDataGeneratedAccessors)

- (void)addSemesterDetailsObject:(SemesterDetails *)value;
- (void)removeSemesterDetailsObject:(SemesterDetails *)value;
- (void)addSemesterDetails:(NSSet *)values;
- (void)removeSemesterDetails:(NSSet *)values;

@end
