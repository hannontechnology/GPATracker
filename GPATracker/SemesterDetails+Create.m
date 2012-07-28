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
    
    
}
@end
