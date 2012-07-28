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
    /*
    SemesterDetails *newSemester = []
    
    return newSemester;*/
    return nil;
}


//- (SemesterDetails *)addSemester:(SemesterDetails *)semester context:(NSManagedObjectContext *)inContext
//{
//    NSString *entityName = @"SemesterDetails";
//    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: entityName];
//    
//    request.predicate = [];
//    
//    
//}
@end
