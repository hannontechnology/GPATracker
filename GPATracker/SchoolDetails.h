//
//  SchoolDetails.h
//  GPATracker
//
//  Created by terryah on 12-06-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * schoolActualGPA;
@property (nonatomic, retain) NSDecimalNumber * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSDate * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSDate * schoolStartYear;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSManagedObject *gradingScheme;

@end
