//
//  HomePageTableCell1.m
//  GPATracker
//
//  Created by terryah on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageTableCell1.h"

@implementation HomePageTableCell1
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
