//
//  GradingScheme+Create.m
//  GPATracker
//
//  Created by David Stevens on 12-07-28.
//
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
    newGradingScheme.school = gradingScheme.school;
    newGradingScheme.gradeAPlus = gradingScheme.gradeAPlus;
    newGradingScheme.gradeA = gradingScheme.gradeA;
    newGradingScheme.gradeAMinus = gradingScheme.gradeAMinus;
    newGradingScheme.gradeB = gradingScheme.gradeB;
    newGradingScheme.gradeBMinus = gradingScheme.gradeBMinus;
    newGradingScheme.gradeBPlus = gradingScheme.gradeBPlus;
    newGradingScheme.gradeC = gradingScheme.gradeC;
    newGradingScheme.gradeCMinus = gradingScheme.gradeCMinus;
    newGradingScheme.gradeCPlus = gradingScheme.gradeCPlus;
    newGradingScheme.gradeD = gradingScheme.gradeD;
    newGradingScheme.gradeF = gradingScheme.gradeF;
    
    if (![inContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    return newGradingScheme;

}
@end
