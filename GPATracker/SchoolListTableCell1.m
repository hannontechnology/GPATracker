//
//  HomePageTableCell1.m
//  GPATracker
//
//  Created by Terry Hannon on 12-07-14.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SchoolListTableCell1.h"

@implementation SchoolListTableCell1
@synthesize cellLabel1;
@synthesize cellLabel2;
@synthesize cellLabel3;
@synthesize cellLabelGPA;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
