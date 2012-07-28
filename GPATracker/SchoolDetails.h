//
//  SchoolDetails.h
//  GPATracker
//
//  Created by David Stevens on 12-07-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme;

@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * schoolActualGPA;
@property (nonatomic, retain) NSDecimalNumber * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSString * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * schoolStartYear;
@property (nonatomic, retain) GradingScheme *gradingScheme;

@end
