//
//  AGGeometry.m
//  no.agens.foldshadow
//
//  Created by Håvard Fossli on 16.08.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "AGGeometry.h"
#import <QuartzCore/QuartzCore.h>
#import "GLKit/GLKMatrix3.h"
#import "GLKit/GLKVector3.h"
#import "AGMath.h"

BOOL VGCornerIsOnSide(VGCorner corner, VGSide side)
{
    return (corner & side) == side;
}

CGPoint VGCornerConvertToAnchorPoint(VGCorner corner)
{
    switch (corner) {
        case VGCornerTopLeft:
            return CGPointMake(0, 0);
            break;
        case VGCornerTopRight:
            return CGPointMake(1, 0);
            break;
        case VGCornerBottomLeft:
            return CGPointMake(0, 1);
            break;
        case VGCornerBottomRight:
            return CGPointMake(1, 1);
            break;
    }
}

CGPoint CGPointForAnchorPointInRect(CGPoint anchor, CGRect rect)
{
    CGPoint point;
    point.x = (anchor.x * rect.size.width) + rect.origin.x;
    point.y = (anchor.y * rect.size.height) + rect.origin.y;
    return point;
}

CGPoint CGPointAnchorForPointInRect(CGPoint point, CGRect rect)
{
    CGPoint anchor = CGPointZero;
    CGPoint minPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    anchor.x = ((point.x - minPoint.x) / rect.size.width);
    anchor.y = ((point.y - minPoint.y) / rect.size.height);
    return anchor;
}

CGPoint CGPointForCenterInRect(CGRect rect)
{
    return CGPointForAnchorPointInRect(CGPointMake(0.5, 0.5), rect);
}

CGPoint VGCornerConvertToPointForRect(VGCorner corner, CGRect rect)
{
    CGPoint anchor = VGCornerConvertToAnchorPoint(corner);
    CGPoint p = CGPointForAnchorPointInRect(anchor, rect);
    return p;
}

double CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2)
{
    CGPoint p = CGPointNormalizedDistance(p1, p2);
    return sqrtf(powf(p.x, 2.0f) + powf(p.y, 2.0f));
}

CGPoint CGPointNormalizedDistance(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p2.x - p1.x, p2.y - p1.y);
}

double CGRectGetAspectRatio(CGRect rect) {
    return rect.size.width / rect.size.height;
}

BOOL CGRectAspectIsWiderThanCGRect(CGRect rect1, CGRect rect2)
{
    double aspect1 = CGRectGetAspectRatio(rect1);
    double aspect2 = CGRectGetAspectRatio(rect1);
    return aspect1 > aspect2;
}

CGSize CGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner)
{
    double outerAspect = outer.width / outer.height;
    double innerAspect = inner.width / inner.height;
    
    if(outerAspect > innerAspect) // outer is wider
    {
        return CGSizeMake(inner.height * outerAspect, inner.height);
    }
    else // outer is thinner
    {
        return CGSizeMake(inner.width, inner.width * outerAspect);
    }
}

BOOL CGSizeEqualToOrGreaterThanSize(CGSize greaterSize, CGSize size2)
{
    return greaterSize.width >= size2.width && greaterSize.height > size2.height;
}

BOOL CGRectGotAnyNanValues(CGRect rect)
{
    return CGSizeGotAnyNanValues(rect.size) || CGPointGotAnyNanValues(rect.origin);
}

BOOL CGSizeGotAnyNanValues(CGSize size)
{
    return size.width == NAN || size.height == NAN;
}

BOOL CGPointGotAnyNanValues(CGPoint origin)
{
    return origin.x == NAN || origin.y == NAN;
}

CGSize CGSizeGreatestSize(CGSize size1, CGSize size2)
{
    if(CGSizeEqualToOrGreaterThanSize(size1, size2))
    {
        return size1;
    }
    else
    {
        return size2;
    }
}

CGSize CGSizeSmallestSize(CGSize size1, CGSize size2)
{
    if(CGSizeEqualToOrGreaterThanSize(size1, size2))
    {
        return size2;
    }
    else
    {
        return size1;
    }
}

double RadiansToDegrees(double radians)
{
    return radians * 180 / M_PI;
}

double DegreesToRadians(double degrees)
{
    return degrees * M_PI / 180;
}

CGPoint CGPointAddSize(CGPoint p, CGSize s)
{
    return CGPointMake(p.x + s.width, p.y + s.height);
}

CGRect CGRectMakeWithSize(CGSize size)
{
    return (CGRect){CGPointZero, size};
}

CGSize CGSizeGetHalf(CGSize size)
{
    return CGSizeMake(size.width / 2.0, size.height / 2.0);
}

CGSize CGSizeFlipped(CGSize size)
{
    return CGSizeMake(size.height, size.width);
}

CGRect CGRectNewWidth(CGRect rect, double newWidth)
{
    rect.size.width = newWidth;
    return rect;
}

CGRect CGRectNewHeight(CGRect rect, double newHeight)
{
    rect.size.height = newHeight;
    return rect;
}

CGRect CGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints)
{
    double greatestXValue = pointsArray[0].x;
    double greatestYValue = pointsArray[0].y;
    double smallestXValue = pointsArray[0].x;
    double smallestYValue = pointsArray[0].y;
    
    for(int i = 1; i < numberOfPoints; i++)
    {
        CGPoint point = pointsArray[i];
        greatestXValue = MAX(greatestXValue, point.x);
        greatestYValue = MAX(greatestYValue, point.y);
        smallestXValue = MIN(smallestXValue, point.x);
        smallestYValue = MIN(smallestYValue, point.y);
    }
    
    CGRect rect;
    rect.origin = CGPointMake(smallestXValue, smallestYValue);
    rect.size.width = greatestXValue - smallestXValue;
    rect.size.height = greatestYValue - smallestYValue;
    
    return rect;
}

CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress)
{
    CGSize result;
    result.width = valueInterpolate(size1.width, size2.width, progress);
    result.height = valueInterpolate(size1.height, size2.height, progress);
    return result;
}

CGSize CGSizeInterpolateWithFunction(CGSize size1, CGSize size2, double progress, AHFloat (*function)(AHFloat))
{
    return CGSizeInterpolate(size1, size2, function(progress));
}

CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress)
{
    CGPoint result;
    result.x = valueInterpolate(point1.x, point2.x, progress);
    result.y = valueInterpolate(point1.y, point2.y, progress);
    return result;
}

CGPoint CGPointInterpolateWithFunction(CGPoint point1, CGPoint point2, double progress, AHFloat (*function)(AHFloat))
{
    return CGPointInterpolate(point1, point2, function(progress));
}

CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress)
{
    CGRect result;
    result.origin = CGPointInterpolate(rect1.origin, rect2.origin, progress);
    result.size = CGSizeInterpolate(rect1.size, rect2.size, progress);
    return result;
}

CGRect CGRectInterpolateWithFunction(CGRect rect1, CGRect rect2, double progress, AHFloat (*function)(AHFloat))
{
    return CGRectInterpolate(rect1, rect2, function(progress));
}

extern BOOL CGPointContainsNaNValues(CGPoint p)
{
    return p.x != p.x || p.y != p.y;
}

BOOL getLineIntersection(double p0_x,
                         double p0_y,
                         double p1_x,
                         double p1_y,
                         double p2_x,
                         double p2_y,
                         double p3_x,
                         double p3_y,
                         double *out_i_x,
                         double *out_i_y)
{    
    // http://stackoverflow.com/a/13981450/202451
    // http://stackoverflow.com/a/14795484/202451
    
    double s02_x, s02_y, s10_x, s10_y, s32_x, s32_y, s_numer, t_numer, denom, t;
    s10_x = p1_x - p0_x;
    s10_y = p1_y - p0_y;
    s32_x = p3_x - p2_x;
    s32_y = p3_y - p2_y;
    
    denom = s10_x * s32_y - s32_x * s10_y;
    if (denom == 0)
        return NO; // Parallel
    
    s02_x = p0_x - p2_x;
    s02_y = p0_y - p2_y;
    s_numer = s10_x * s02_y - s10_y * s02_x;
    if (s_numer < 0)
        return NO; // No collision
    
    t_numer = s32_x * s02_y - s32_y * s02_x;
    if (t_numer < 0)
        return NO; // No collision
    
    if (s_numer > denom || t_numer > denom)
        return NO; // No collision
    
    // Collision detected
    t = t_numer / denom;
    if (out_i_x != NULL)
        *out_i_x = p0_x + (t * s10_x);
    if (out_i_y != NULL)
        *out_i_y = p0_y + (t * s10_y);
    
    return YES;
}
