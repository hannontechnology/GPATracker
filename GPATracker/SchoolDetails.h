//
//  SchoolDetails.h
//  GPATracker
//
//  Created by terryah on 12-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GradingScheme, User;

@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * schoolActualGPA;
@property (nonatomic, retain) NSDecimalNumber * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSString * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * schoolStartYear;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) GradingScheme *gradingScheme;
@property (nonatomic, retain) User *users;

@end
