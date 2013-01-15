//
//  SchoolDetails+Create.h
//  GPATracker
//
//  Created by Terry Hannon on 12-07-28.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SchoolDetails.h"

@interface SchoolDetails (Create)
- (SchoolDetails *)addSchool:(SchoolDetails *)school context:(NSManagedObjectContext *)inContext;

@end
