//
//  Course.h
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * actualGrade;
@property (nonatomic, retain) NSNumber * calculatedGrade;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSNumber * desiredGrade;
@property (nonatomic, retain) NSNumber * includeInGPA;
@property (nonatomic, retain) NSNumber * isPassFail;
@property (nonatomic, retain) NSNumber * units;

@end
