//
//  SyllabusTableCell1.m
//  GPATracker
//
//  Created by David Stevens on 13-03-19.
//
//

#import "SyllabusListTableCell1.h"

@implementation SyllabusListTableCell1
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
