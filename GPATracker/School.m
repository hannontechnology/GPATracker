//
//  School.m
//  GPATracker
//
//  Created by David Stevens on 12-05-10.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import "School.h"

@implementation School

@synthesize schoolId = _schoolId, schoolName = _schoolName,schoolDetail = _schoolDetail, startYear = _startYear, endYear = _endYear;

- (id)initWithschoolId:(NSNumber *)schoolId schoolName:(NSString *)schoolName schoolDetail:(NSString *)schoolDetail startYear:(NSDate *)startYear endYear:(NSDate *)endYear {
    
    self = [super init];
    if (self) {
        _schoolId = schoolId;
        _schoolName = schoolName;
        _schoolDetail = schoolDetail;
        _startYear = startYear;
        _endYear = endYear;
        return self;
    }
    return nil;
}
@end
