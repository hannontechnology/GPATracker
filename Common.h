//
//  Common.h
//  GPATracker
//
//  Created by Terry Hannon on 13-02-23.
//
//

#import <Foundation/Foundation.h>

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
CGRect rectFor1PxStroke(CGRect rect);
static inline double radians (double degrees) { return degrees * M_PI/180; }
CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);