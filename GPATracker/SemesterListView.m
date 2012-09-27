//
//  SemesterListView.m
//  GPATracker
//
//  Created by Terry Hannon on 12-09-26.
//
//

#import "SemesterListView.h"

@implementation SemesterListView
@synthesize tableView;
@synthesize schoolInfo = _schoolInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)DisplaySemesters:(SchoolDetails *)inSchool
{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //sets the editing style for every row.
    return UITableViewCellEditingStyleDelete;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
