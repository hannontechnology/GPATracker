//
//  SchoolDetails.h
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SchoolDetails : NSManagedObject

@property (nonatomic, retain) NSString * schoolActualGPA;
@property (nonatomic, retain) NSString * schoolCalculatedGPA;
@property (nonatomic, retain) NSString * schoolDetails;
@property (nonatomic, retain) NSString * schoolEndYear;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * schoolStartYear;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSManagedObject *gradingScheme;

@end
