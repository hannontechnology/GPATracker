//
//  GradingScheme.h
//  GPATracker
//
//  Created by David Stevens on 12-06-14.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GradingScheme : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * gradeA;
@property (nonatomic, retain) NSDecimalNumber * gradeAMinus;
@property (nonatomic, retain) NSDecimalNumber * gradeAPlus;
@property (nonatomic, retain) NSDecimalNumber * gradeB;
@property (nonatomic, retain) NSDecimalNumber * gradeBMinus;
@property (nonatomic, retain) NSDecimalNumber * gradeBPlus;
@property (nonatomic, retain) NSDecimalNumber * gradeC;
@property (nonatomic, retain) NSDecimalNumber * gradeCMinus;
@property (nonatomic, retain) NSDecimalNumber * gradeCPlus;
@property (nonatomic, retain) NSDecimalNumber * gradeD;
@property (nonatomic, retain) NSDecimalNumber * gradeF;

@end
