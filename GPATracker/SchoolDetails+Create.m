//
//  SchoolDetails+Create.m
//  GPATracker
//
//  Created by Terry Hannon on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SchoolDetails+Create.h"

@implementation SchoolDetails (Create)
- (SchoolDetails *)addSchool:(SchoolDetails *)school context:(NSManagedObjectContext *)inContext
{
    NSString *entityName = @"SchoolDetails"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"SchoolDetails = %@", SchoolDetails.schoolName];
    NSLog(@"filtering data based on schoolName = %@", SchoolDetails.schoolName);
    NSError *error = nil;
    NSArray *results = [inContext executeFetchRequest:request error:&error];
    if ([results count] != 0)
    {
        NSLog(@"Whoops, couldn't save: School already exists");
        return nil;
    }
    
    SchoolDetails *newSchool = [NSEntityDescription
                                       insertNewObjectForEntityForName:entityName
                                       inManagedObjectContext:inContext];
    newSchool.schoolName = SchoolDetails.schoolName;
    newSchool.schoolDetails = SchoolDetails.schoolDetails;
    newSchool.schoolStartYear = SchoolDetails.schoolStartYear;
    newSchool.schoolEndYear = SchoolDetails.schoolEndYear;
    
        
    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    return newGradingScheme;
 
}
@end
