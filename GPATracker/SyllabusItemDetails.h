//
//  SyllabusItemDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-04-13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SyllabusDetails;

@interface SyllabusItemDetails : NSManagedObject

@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSDate * itemDueDate;
@property (nonatomic, retain) NSDecimalNumber * itemScore;
@property (nonatomic, retain) NSDecimalNumber * itemOutOf;
@property (nonatomic, retain) SyllabusDetails *syllabusDetails;

@end
