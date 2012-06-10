//
//  Semester.h
//  GPATracker
//
//  Created by terryah on 12-06-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Semester : NSManagedObject

@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSNumber * detailFlag;

@end
