//
//  GradingScheme+Create.m
//  GPATracker
//
//  Created by David Stevens on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "GradingScheme+Create.h"

@implementation GradingScheme (Create)
- (GradingScheme *)addGradingScheme:(GradingScheme *)gradingScheme context:(NSManagedObjectContext *)inContext
{
    NSString *entityName = @"GradingScheme"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"gradingScheme = %@", gradingScheme.school];
    NSLog(@"filtering data based on userName = %@", gradingScheme.school);
    NSError *error = nil;
    NSArray *results = [inContext executeFetchRequest:request error:&error];
    if ([results count] != 0)
    {
        NSLog(@"Whoops, couldn't save: GradingScheme already exists");
        return nil;
    }
    
    GradingScheme *newGradingScheme = [NSEntityDescription
                     insertNewObjectForEntityForName:entityName
                     inManagedObjectContext:inContext];
    newGradingScheme.letterGrade = gradingScheme.letterGrade;
    newGradingScheme.gPA = gradingScheme.gPA;
    
    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    return newGradingScheme;

}
@end
