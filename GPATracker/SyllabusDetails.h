//
//  SyllabusDetails.h
//  GPATracker
//
//  Created by David Stevens on 13-03-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails;

@interface SyllabusDetails : NSManagedObject

@property (nonatomic, retain) NSString *sectionName;
@property (nonatomic, retain) NSNumber *percentBreakdown;

@end
