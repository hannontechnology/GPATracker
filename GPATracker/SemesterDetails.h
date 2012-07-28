//
//  SemesterDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, SchoolDetails;

@interface SemesterDetails : NSManagedObject

@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * semesterYear;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) SchoolDetails *schoolDetails;
@property (nonatomic, retain) Course *course;

@end
