//
//  SemesterDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-01-04.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails, SchoolDetails;

@interface SemesterDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * semesterYear;
@property (nonatomic, retain) NSSet *courseDetails;
@property (nonatomic, retain) SchoolDetails *schoolDetails;
@end

@interface SemesterDetails (CoreDataGeneratedAccessors)

- (void)addCourseDetailsObject:(CourseDetails *)value;
- (void)removeCourseDetailsObject:(CourseDetails *)value;
- (void)addCourseDetails:(NSSet *)values;
- (void)removeCourseDetails:(NSSet *)values;

@end
