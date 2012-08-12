//
//  GradingScheme.h
//  GPATracker
//
//  Created by Terry Hannon on 12-08-06.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SchoolDetails;

@interface GradingScheme : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * gPA;
@property (nonatomic, retain) NSString * letterGrade;
@property (nonatomic, retain) SchoolDetails *school;

@end
