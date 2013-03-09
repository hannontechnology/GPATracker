//
//  CustomCellBackground.h
//  GPATracker
//
//  Created by Terry Hannon on 13-02-23.
//
//

#import <UIKit/UIKit.h>

@interface CustomCellBackground : UIView
{
    // Inside @interface
    BOOL _lastCell;
    BOOL _selected;
}

// After @interface
@property  BOOL lastCell;
@property  BOOL selected;
@end
