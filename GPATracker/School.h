//
//  School.h
//  GPATracker
//
//  Created by David Stevens on 12-05-10.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School : NSManagedObject

@property (nonatomic, retain) NSNumber * schoolId;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * schoolDetail;
@property (nonatomic, retain) NSDate * startYear;
@property (nonatomic, retain) NSDate * endYear;

- (id)initWithschoolId:(NSNumber *)schoolId schoolName:(NSString *)schoolName schoolDetail:(NSString *)schoolDetail startYear:(NSDate *)startYear endYear:(NSDate *)endYear;

@end
