//
//  SemesterDetails.h
//  GPATracker
//
//  Created by Aiste Guden on 12-05-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SemesterDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * semesterYear;

@end
