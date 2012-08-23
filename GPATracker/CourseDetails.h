//
//  CourseDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, SemesterDetails;

@interface CourseDetails : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDesc;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) SemesterDetails *semesterDetails;
@property (nonatomic, retain) GradingScheme *actualGradeGPA;
@property (nonatomic, retain) GradingScheme *desiredGradeGPA;

@end
