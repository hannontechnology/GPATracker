//
//  SyllabusDetails+Create.m
//  GPATracker
//
//  Created by David Stevens on 13-04-04.
//
//

#import "SyllabusDetails+Create.h"
#import "CourseDetails.h"

@implementation SyllabusDetails (Create)

-(NSString*) sectionName{
    return [NSString stringWithFormat:@"%@", self.sectionName];
}

@end
