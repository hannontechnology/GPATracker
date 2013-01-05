//
//  GradingScheme.h
//  GPATracker
//
//  Created by Terry Hannon on 13-01-04.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails, SchoolDetails;

@interface GradingScheme : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * gPA;
@property (nonatomic, retain) NSString * letterGrade;
@property (nonatomic, retain) NSSet *actualGPAGrade;
@property (nonatomic, retain) NSSet *desiredGPAGrade;
@property (nonatomic, retain) SchoolDetails *school;
@end

@interface GradingScheme (CoreDataGeneratedAccessors)

- (void)addActualGPAGradeObject:(CourseDetails *)value;
- (void)removeActualGPAGradeObject:(CourseDetails *)value;
- (void)addActualGPAGrade:(NSSet *)values;
- (void)removeActualGPAGrade:(NSSet *)values;

- (void)addDesiredGPAGradeObject:(CourseDetails *)value;
- (void)removeDesiredGPAGradeObject:(CourseDetails *)value;
- (void)addDesiredGPAGrade:(NSSet *)values;
- (void)removeDesiredGPAGrade:(NSSet *)values;

@end
