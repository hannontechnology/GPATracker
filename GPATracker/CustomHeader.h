//
//  CustomHeader.h
//  GPATracker
//
//  Created by Terry Hannon on 13-02-24.
//
//

#import <UIKit/UIKit.h>

@interface CustomHeader : UIView
{
    UILabel *_titleLabel;
    UIColor *_lightColor;
    UIColor *_darkColor;
    CGRect _coloredBoxRect;
    CGRect _paperRect;
}

@property (retain) UILabel *titleLabel;
@property (retain) UIColor *lightColor;
@property (retain) UIColor *darkColor;
@end
