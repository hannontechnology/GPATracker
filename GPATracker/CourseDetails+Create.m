//
//  SchoolDetails+Create.m
//  GPATracker
//
//  Created by Terry Hannon on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "CourseDetails+Create.h"
#import "SemesterDetails.h"

@implementation CourseDetails (Create)

-(NSString*) sectionName{
    return [NSString stringWithFormat:@"%@-%@", self.semesterDetails.semesterYear, self.semesterDetails.semesterName];
}

@end
