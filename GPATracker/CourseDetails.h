//
//  CourseDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-04-11.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, SemesterDetails, SyllabusDetails;

@interface CourseDetails : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDesc;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) GradingScheme *actualGradeGPA;
@property (nonatomic, retain) GradingScheme *desiredGradeGPA;
@property (nonatomic, retain) SemesterDetails *semesterDetails;
@property (nonatomic, retain) NSSet *syllabusDetails;
@end

@interface CourseDetails (CoreDataGeneratedAccessors)

- (void)addSyllabusDetailsObject:(SyllabusDetails *)value;
- (void)removeSyllabusDetailsObject:(SyllabusDetails *)value;
- (void)addSyllabusDetails:(NSSet *)values;
- (void)removeSyllabusDetails:(NSSet *)values;

@end
