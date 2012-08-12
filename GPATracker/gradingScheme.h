//
//  GradingScheme.h
//  GPATracker
//
//  Created by David Stevens on 12-08-12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SchoolDetails;

@interface GradingScheme : NSManagedObject

@property (nonatomic, retain) NSString * letterGrade;
@property (nonatomic, retain) NSDecimalNumber * gPA;
@property (nonatomic, retain) SchoolDetails *school;

@end
