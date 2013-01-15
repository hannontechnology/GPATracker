//
//  SemesterDetails+Create.h
//  GPATracker
//
//  Created by Aiste Guden on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SemesterDetails.h"

@interface SemesterDetails (Create)
- (SemesterDetails *)addSemester:(SemesterDetails *)semester context:(NSManagedObjectContext *)inContext;
@end
