//
//  AGGeometry.h
//  no.agens.foldshadow
//
//  Created by Håvard Fossli on 16.08.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "easing.h"

// http://processingjs.nihongoresources.com/bezierinfo/

typedef enum VGAxis {
    VGAxisX,
    VGAxisY,
    VGAxizZ,
} VGAxis;

typedef enum VGSide {
    VGSideTop = 1 << 0,
    VGSideBottom = 1 << 1,
    VGSideLeft = 1 << 2,
    VGSideRight = 1 << 3,
} VGSide;

typedef enum {
    VGCornerTopLeft = VGSideTop | VGSideLeft,
    VGCornerTopRight = VGSideTop | VGSideRight,
    VGCornerBottomLeft = VGSideBottom | VGSideLeft,
    VGCornerBottomRight = VGSideBottom | VGSideRight,
} VGCorner;

BOOL VGCornerIsOnSide(VGCorner corner, VGSide side);
CGPoint VGCornerConvertToAnchorPoint(VGCorner corner);
CGPoint CGPointForAnchorPointInRect(CGPoint anchor, CGRect rect);
CGPoint CGPointAnchorForPointInRect(CGPoint point, CGRect rect);
CGPoint CGPointForCenterInRect(CGRect rect);
CGPoint VGCornerConvertToPointForRect(VGCorner corner, CGRect rect);
double CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2);
CGPoint CGPointNormalizedDistance(CGPoint p1, CGPoint p2);
double CGRectGetAspectRatio(CGRect rect);
CGSize CGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner);
BOOL CGRectAspectIsWiderThanCGRect(CGRect rect1, CGRect rect2);
BOOL CGSizeEqualToOrGreaterThanSize(CGSize greaterSize, CGSize size2);
BOOL CGRectGotAnyNanValues(CGRect rect);
BOOL CGSizeGotAnyNanValues(CGSize size);
BOOL CGPointGotAnyNanValues(CGPoint origin);
CGSize CGSizeGreatestSize(CGSize size1, CGSize size2);
CGSize CGSizeSmallestSize(CGSize size1, CGSize size2);
double RadiansToDegrees(double radians);
double DegreesToRadians(double degrees);
CGPoint CGPointAddSize(CGPoint p, CGSize s);
CGRect CGRectMakeWithSize(CGSize size);
CGSize CGSizeGetHalf(CGSize size);
CGSize CGSizeFlipped(CGSize size);
CGRect CGRectNewWidth(CGRect rect, double newWidth);
CGRect CGRectNewHeight(CGRect rect, double newHeight);
CGRect CGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints);
CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress);
CGPoint CGPointInterpolateWithFunction(CGPoint point1, CGPoint point2, double progress, AHFloat (*function)(AHFloat));
CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress);
CGSize CGSizeInterpolateWithFunction(CGSize size1, CGSize size2, double progress, AHFloat (*function)(AHFloat));
CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress);
CGRect CGRectInterpolateWithFunction(CGRect rect1, CGRect rect2, double progress, float (*function)(float));
inline BOOL CGPointContainsNaNValues(CGPoint p);

BOOL getLineIntersection(double p0_x,
                         double p0_y,
                         double p1_x,
                         double p1_y,
                         double p2_x,
                         double p2_y,
                         double p3_x,
                         double p3_y,
                         double *out_i_x,
                         double *out_i_y);
