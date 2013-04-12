//
//  SyllabusDetails.h
//  GPATracker
//
//  Created by Terry Hannon on 13-04-11.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDetails, SyllabusItemDetails;

@interface SyllabusDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * percentBreakdown;
@property (nonatomic, retain) NSString * sectionName;
@property (nonatomic, retain) CourseDetails *courseDetails;
@property (nonatomic, retain) NSSet *syllabusItemDetails;
@end

@interface SyllabusDetails (CoreDataGeneratedAccessors)

- (void)addSyllabusItemDetailsObject:(SyllabusItemDetails *)value;
- (void)removeSyllabusItemDetailsObject:(SyllabusItemDetails *)value;
- (void)addSyllabusItemDetails:(NSSet *)values;
- (void)removeSyllabusItemDetails:(NSSet *)values;

@end
