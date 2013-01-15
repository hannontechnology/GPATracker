//
//  GradingScheme+Create.h
//  GPATracker
//
//  Created by David Stevens on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "gradingScheme.h"

@interface GradingScheme (Create)
- (GradingScheme *)addGradingScheme:(GradingScheme *)gradingScheme context:(NSManagedObjectContext *)inContext;

@end
