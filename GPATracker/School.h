//
//  School.h
//  GPATracker
//
//  Created by David Stevens on 12-05-10.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School : UIViewController

@property (nonatomic, copy) NSNumber * schoolId;
@property (nonatomic, copy) NSString * schoolName;
@property (nonatomic, copy) NSString * schoolDetail;
@property (nonatomic, copy) NSDate * startYear;
@property (nonatomic, copy) NSDate * endYear;

@end
