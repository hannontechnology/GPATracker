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

-(NSString*) groupName{
    return [NSString stringWithFormat:@"%@-%@", self.sectionName, self.percentBreakdown];
}

@end
