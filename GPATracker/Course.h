//
//  Course.h
//  GPATracker
//
//  Created by Aiste Guden on 12-05-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) NSNumber * calculatedGrade;
@property (nonatomic, retain) NSNumber * desiredGrade;
@property (nonatomic, retain) NSDecimalNumber * actualGrade;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSNumber * includeInGPA;

@end
