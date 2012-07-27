//
//  SemesterDetails.h
//  GPATracker
//
//  Created by terryah on 12-07-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SemesterDetails : NSManagedObject

@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSNumber * semesterCode;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * semesterYear;
@property (nonatomic, retain) NSString * userName;

@end
