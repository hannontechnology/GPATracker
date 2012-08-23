//
//  GradingScheme.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails, SchoolDetails;

@interface GradingScheme : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * gPA;
@property (nonatomic, retain) NSString * letterGrade;
@property (nonatomic, retain) SchoolDetails *school;
@property (nonatomic, retain) CourseDetails *actualGPAGrade;
@property (nonatomic, retain) CourseDetails *desiredGPAGrade;

@end
