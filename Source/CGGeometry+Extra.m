//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CGGeometry+Extra.h"
#import <QuartzCore/QuartzCore.h>
#import "GLKit/GLKMatrix3.h"
#import "GLKit/GLKVector3.h"
#import "AGMath.h"
#import "pthread.h"

CGPoint CGPointGetPointForAnchorPointInRect(CGPoint anchor, CGRect rect)
{
    CGPoint point;
    point.x = (anchor.x * rect.size.width) + rect.origin.x;
    point.y = (anchor.y * rect.size.height) + rect.origin.y;
    return point;
}

CGPoint CGPointGetAnchorPointForPointInRect(CGPoint point, CGRect rect)
{
    CGPoint anchor = CGPointZero;
    CGPoint minPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    anchor.x = ((point.x - minPoint.x) / rect.size.width);
    anchor.y = ((point.y - minPoint.y) / rect.size.height);
    return anchor;
}

CGPoint CGPointForCenterInRect(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

extern CGFloat CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2)
{
    CGPoint p = CGPointNormalizedDistance(p1, p2);
    return sqrtf(powf(p.x, 2.0f) + powf(p.y, 2.0f));
}

extern CGPoint CGPointNormalizedDistance(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p2.x - p1.x, p2.y - p1.y);
}

extern double CGSizeGetAspectRatio(CGSize size) {
    return size.width / size.height;
}

extern BOOL CGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2)
{
    double aspect1 = CGSizeGetAspectRatio(size1);
    double aspect2 = CGSizeGetAspectRatio(size2);
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

extern BOOL CGRectGotAnyNanValues(CGRect rect)
{
    return CGSizeGotAnyNanValues(rect.size) || CGPointGotAnyNanValues(rect.origin);
}

extern BOOL CGSizeGotAnyNanValues(CGSize size)
{
    // which is better 'a == NAN' or 'a != a'?
    return size.width == NAN || size.height == NAN;
}

extern BOOL CGPointGotAnyNanValues(CGPoint origin)
{
    // which is better 'a == NAN' or 'a != a'?
    return origin.x == NAN || origin.y == NAN;
}

extern CGPoint CGPointAddSize(CGPoint p, CGSize s)
{
    return CGPointMake(p.x + s.width, p.y + s.height);
}

extern CGRect CGRectMakeWithSize(CGSize size)
{
    return (CGRect){CGPointZero, size};
}

extern CGPoint CGRectGetMidPoint(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

extern CGSize CGSizeGetHalf(CGSize size)
{
    return CGSizeMake(size.width / 2.0, size.height / 2.0);
}

extern CGSize CGSizeSwitchAxis(CGSize size)
{
    return CGSizeMake(size.height, size.width);
}

extern CGRect CGRectWithSize(CGRect rect, CGSize newSize)
{
    rect.size = newSize;
    return rect;
}

extern CGRect CGRectWithWidth(CGRect rect, CGFloat newWidth)
{
    rect.size.width = newWidth;
    return rect;
}

extern CGRect CGRectWithHeight(CGRect rect, CGFloat newHeight)
{
    rect.size.height = newHeight;
    return rect;
}

extern CGRect CGRectWithOrigin(CGRect rect, CGPoint origin)
{
    rect.origin = origin;
    return rect;
}

extern CGRect CGRectWithOriginMinX(CGRect rect, CGFloat value)
{
    rect.origin.x = value;
    return rect;
}

extern CGRect CGRectWithOriginMinY(CGRect rect, CGFloat value)
{
    rect.origin.y = value;
    return rect;
}

extern CGRect CGRectWithOriginMaxY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - rect.size.height;
    return rect;
}

extern CGRect CGRectWithOriginMaxX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - rect.size.width;
    return rect;
}

extern CGRect CGRectWithOriginMidX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - (rect.size.width / 2.0);
    return rect;
}

extern CGRect CGRectWithOriginMidY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - (rect.size.height / 2.0);
    return rect;
}

extern CGRect CGRectApply(CGRect rect, CGRect (^block)(CGRect rect))
{
    return block(rect);
}

extern CGSize CGSizeApply(CGSize size, CGSize (^block)(CGSize size))
{
    return block(size);
}

extern CGPoint CGPointApply(CGPoint point, CGPoint (^block)(CGPoint point))
{
    return block(point);
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

CGSize CGSizeDistanceBetweenRects(CGRect rect1, CGRect rect2)
{
    if (CGRectIntersectsRect(rect1, rect2))
    {
        return CGSizeMake(0, 0);
    }
    
    CGRect mostLeft = rect1.origin.x < rect2.origin.x ? rect1 : rect2;
    CGRect mostRight = rect2.origin.x < rect1.origin.x ? rect1 : rect2;
    
    CGFloat xDifference = mostLeft.origin.x == mostRight.origin.x ? 0 : mostRight.origin.x - (mostLeft.origin.x + mostLeft.size.width);
    xDifference = MAX(0, xDifference);
    
    CGRect upper = rect1.origin.y < rect2.origin.y ? rect1 : rect2;
    CGRect lower = rect2.origin.y < rect1.origin.y ? rect1 : rect2;
    
    CGFloat yDifference = upper.origin.y == lower.origin.y ? 0 : lower.origin.y - (upper.origin.y + upper.size.height);
    yDifference = MAX(0, yDifference);
    
    return CGSizeMake(xDifference, yDifference);
}

CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress)
{
    CGSize result;
    result.width = interpolate(size1.width, size2.width, progress);
    result.height = interpolate(size1.height, size2.height, progress);
    return result;
}

CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress)
{
    CGPoint result;
    result.x = interpolate(point1.x, point2.x, progress);
    result.y = interpolate(point1.y, point2.y, progress);
    return result;
}

CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress)
{
    CGRect result;
    result.origin = CGPointInterpolate(rect1.origin, rect2.origin, progress);
    result.size = CGSizeInterpolate(rect1.size, rect2.size, progress);
    return result;
}

// http://stackoverflow.com/a/15328910/202451

CGPoint CGPointApplyCATransform3D(CGPoint point, CATransform3D transform, CGPoint anchorPoint, CATransform3D parentSublayerTransform)
{
    
    static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
    static CALayer *sublayer, *layer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sublayer = [CALayer layer];
        layer = [CALayer layer];
        [layer addSublayer:sublayer];
    });
    
    if(pthread_mutex_lock(&mtx))
    {
        [NSException raise:NSInternalInconsistencyException format:@"pthread_mutex_lock failed"];
    }
    
    layer.sublayerTransform = parentSublayerTransform;
    sublayer.transform = transform;
    sublayer.anchorPoint = anchorPoint;
    CGPoint retval = [sublayer convertPoint:point toLayer:layer];
    
    if(pthread_mutex_unlock(&mtx) != 0)
    {
        [NSException raise:NSInternalInconsistencyException format:@"pthread_mutex_unlock failed"];
    } 
    
    return retval;
}

extern CGPoint CGPointVectorNormalize(CGPoint v)
{
    CGFloat length = CGPointVectorGetLength(v);
    if(length != 0.0)
    {
        v.x /= length;
        v.y /= length;
    }
    return v;
}

extern CGFloat CGPointVectorGetLength(CGPoint v)
{
    return sqrtf(v.x * v.x + v.y * v.y);
}

extern CGFloat CGPointVectorDotProduct(CGPoint v1, CGPoint v2)
{
    return (v1.x * v2.x + v1.y * v2.y);
}

extern CGFloat CGPointVectorCrossProductZComponent(CGPoint v1, CGPoint v2)
{
    return v1.x * v2.y - v1.y * v2.x;
}
