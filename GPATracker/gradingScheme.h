//
//  gradingScheme.h
//  GPATracker
//
//  Created by David Stevens on 12-05-10.
//  Copyright (c) 2012 Hannon Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gradingScheme : UIViewController

@property (nonatomic, retain) NSNumber * gradeAPlus;
@property (nonatomic, retain) NSNumber * gradeA;
@property (nonatomic, retain) NSNumber * gradeAMinus;
@property (nonatomic, retain) NSNumber * gradeBPlus;
@property (nonatomic, retain) NSNumber * gradeB;
@property (nonatomic, retain) NSNumber * gradeBMinus;
@property (nonatomic, retain) NSNumber * gradeCPlus;
@property (nonatomic, retain) NSNumber * gradeC;
@property (nonatomic, retain) NSNumber * gradeCMinus;
@property (nonatomic, retain) NSNumber * gradeD;
@property (nonatomic, retain) NSNumber * gradeF;


-(id)initGradingScheme:(NSNumber *)schoolId gradeAPlus:(NSNumber *)gradeAPlus gradeA:(NSNumber *)gradeA gradeAMinus:(NSNumber *)gradeAMinus gradeBPlus:(NSNumber *)gradeBPlus gradeB:(NSNumber *)gradeB gradeBMinus:(NSNumber *)gradeBMinus gradeCPlus:(NSNumber *)gradeCPlus gradeC:(NSNumber *)gradeC gradeCMinus:(NSNumber *)gradeCMinus gradeD:(NSNumber *)gradeD gradeF:(NSNumber *)gradeF;

@end
