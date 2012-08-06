//
//  CourseDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-06.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SemesterDetails;

@interface CourseDetails : NSManagedObject

@property (nonatomic, retain) NSString * actualGrade;
@property (nonatomic, retain) NSString * calculatedGrade;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDesc;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * desiredGrade;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) SemesterDetails *semesterDetails;

@end
