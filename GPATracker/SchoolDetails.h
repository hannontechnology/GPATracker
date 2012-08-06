//
//  SchoolDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-06.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, SemesterDetails, User;

@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * schoolActualGPA;
@property (nonatomic, retain) NSDecimalNumber * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSString * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * schoolStartYear;
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
