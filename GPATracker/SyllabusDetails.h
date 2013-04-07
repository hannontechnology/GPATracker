//
//  SyllabusDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-04-07.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails;

@interface SyllabusDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * percentBreakdown;
@property (nonatomic, retain) NSString * sectionName;
@property (nonatomic, retain) CourseDetails *courseDetails;

@end
