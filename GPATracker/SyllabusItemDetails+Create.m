//
//  SyllabusDetails+Create.m
//  GPATracker
//
//  Created by David Stevens on 13-04-04.
//
//

#import "SyllabusItemDetails+Create.h"

@implementation SyllabusItemDetails (Create)

-(NSString*) groupName
{
    NSDate *currDate = [NSDate date];
    NSDate *upcDate = [currDate dateByAddingTimeInterval:60*60*24*7];
    NSDate *dueDate = [self itemDueDate];
    NSString *grpName;
    if ([[dueDate laterDate:currDate] isEqualToDate:currDate])
        grpName = @"Over Due";
    else if ([[dueDate laterDate:upcDate] isEqualToDate:upcDate])
        grpName = @"Currently Due";
    else
        grpName = @"Upcoming";
    
    return [NSString stringWithFormat:@"%@", grpName];
}

@end
