//
//  SyllabusItemDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-05-08.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SyllabusDetails;

@interface SyllabusItemDetails : NSManagedObject

@property (nonatomic, retain) NSDate * itemDueDate;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSDecimalNumber * itemOutOf;
@property (nonatomic, retain) NSDecimalNumber * itemScore;
@property (nonatomic, retain) NSNumber * itemComplete;
@property (nonatomic, retain) NSNumber * itemInclude;
@property (nonatomic, retain) SyllabusDetails *syllabusDetails;

@end
