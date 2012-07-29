//
//  SemesterDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-29.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, SchoolDetails;

@interface SemesterDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * semesterYear;
@property (nonatomic, retain) Course *courseDetails;
@property (nonatomic, retain) SchoolDetails *schoolDetails;

@end
