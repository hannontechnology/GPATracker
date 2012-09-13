//
//  GradingSchemeCell1.m
//  GPATracker
//
//  Created by David Stevens on 12-09-12.
//
//

#import "GradingSchemeCell1.h"

@implementation GradingSchemeCell1
@synthesize cellLabel1;
@synthesize cellField1;

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
