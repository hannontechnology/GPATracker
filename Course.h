//
//  Course.h
//  GPATracker
//
//  Created by terryah on 12-07-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * actualGrade;
@property (nonatomic, retain) NSNumber * calculatedGrade;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDesc;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * desiredGrade;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * semesterName;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) NSString * userName;

@end
