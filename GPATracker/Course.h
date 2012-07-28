//
//  Course.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SemesterDetails;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * actualGrade;
@property (nonatomic, retain) NSNumber * calculatedGrade;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDesc;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * desiredGrade;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) SemesterDetails *semesterDetails;

@end
