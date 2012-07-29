//
//  SemesterDetails+Create.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-28.
//
//

#import "SemesterDetails+Create.h"

@implementation SemesterDetails (Create)
- (SemesterDetails *)addSemester:(SemesterDetails *)semester context:(NSManagedObjectContext *)inContext
{
    NSString *entityName = @"SemesterDetails";
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    request.predicate = [NSPredicate predicateWithFormat:@"schoolDetails = %@ AND semesterName = %@ AND semesterYear = %@", semester.schoolDetails, semester.semesterName, semester.semesterYear];
    NSLog(@"Filtering data based on schoolDetails = %@, semesterName = %@, semesterYear = %@", semester.schoolDetails, semester.semesterName, semester.semesterYear);
    NSError *error = nil;
    NSArray *results = [inContext executeFetchRequest:request error:&error];
    if([results count] != 0)
    {
        NSLog(@"OMGWTF, couldn't save: semester already exists");
        return nil;
    }
    
    SemesterDetails *newSemester = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:inContext];
    newSemester.semesterName = semester.semesterName;
    newSemester.semesterYear = semester.semesterYear;
    newSemester.semesterCode = semester.semesterCode;
    newSemester.schoolDetails = self.schoolDetails;
    
    if(![inContext save:&error])
    {
        NSLog(@"Boo. Couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    else
    {
        NSLog(@"Save was successful");
    }
    
    return newSemester;
}

@end
