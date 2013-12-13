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

#import "CGGeometry+AGGeometryKit.h"
#import <QuartzCore/QuartzCore.h>
#import "GLKit/GLKMatrix3.h"
#import "GLKit/GLKVector3.h"
#import "AGMath.h"
#import "pthread.h"

#pragma mark - CGPoint

extern BOOL AGCGPointGotAnyNanValues(CGPoint origin)
{
    // which is better 'a == NAN' or 'a != a'?
    return origin.x == NAN || origin.y == NAN;
}

extern CGPoint AGCGPointModified(CGPoint point, CGPoint (^block)(CGPoint point))
{
    return block(point);
}

extern CGPoint AGCGPointAdd(CGPoint p1, CGPoint p2)
{
    return (CGPoint){p1.x + p2.x, p1.y + p2.y};
}

extern CGPoint AGCGPointAddSize(CGPoint p, CGSize s)
{
    return CGPointMake(p.x + s.width, p.y + s.height);
}

extern CGPoint AGCGPointSubtract(CGPoint p1, CGPoint p2)
{
    return (CGPoint){p1.x - p2.x, p1.y - p2.y};
}

extern CGPoint AGCGPointMultiply(CGPoint p1, CGFloat factor)
{
    return (CGPoint){p1.x * factor, p1.y * factor};
}

extern CGPoint AGCGPointDivide(CGPoint p1, CGFloat factor)
{
    return (CGPoint){p1.x / factor, p1.y / factor};
}

extern CGPoint AGCGPointNormalize(CGPoint v)
{
    CGFloat length = AGCGPointLength(v);
    if(length != 0.0)
    {
        v.x /= length;
        v.y /= length;
    }
    return v;
}

extern CGFloat AGCGPointDotProduct(CGPoint p1, CGPoint p2)
{
    return (p1.x * p2.x) + (p1.y * p2.y);
}

extern CGFloat AGCGPointCrossProductZComponent(CGPoint v1, CGPoint v2)
{
    return v1.x * v2.y - v1.y * v2.x;
}

extern CGFloat AGCGPointLength(CGPoint v)
{
    return sqrtf(v.x * v.x + v.y * v.y);
}

extern CGFloat AGCGPointLengthBetween(CGPoint p1, CGPoint p2)
{
    CGPoint p = CGPointMake(p2.x - p1.x, p2.y - p1.y);
    return sqrtf(powf(p.x, 2.0f) + powf(p.y, 2.0f));
}

CGPoint AGCGPointApplyCATransform3D(CGPoint point,
                                    CATransform3D transform,
                                    CGPoint anchorPoint,
                                    CATransform3D parentSublayerTransform)
{
    // http://stackoverflow.com/a/15328910/202451

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

extern CGPoint AGCGPointRotate(CGPoint point, CGFloat angle)
{
    return AGCGPointRotateAroundOrigin(point, angle, CGPointZero);
}

extern CGPoint AGCGPointRotateAroundOrigin(CGPoint point, CGFloat angle, CGPoint origin)
{
    point = AGCGPointSubtract(point, origin);

    CGFloat cosa = cosf(angle);
    CGFloat sina = sinf(angle);

    CGPoint r;
	r.x = point.x*cosa - point.y*sina;
	r.y = point.x*sina + point.y*cosa;

    return AGCGPointAdd(r, origin);
}

extern CGPoint AGCGPointRotate90DegreesCW(CGPoint point)
{
    return AGCGPointRotate90DegreesCWAroundPoint(point, CGPointZero);
}

extern CGPoint AGCGPointRotate90DegreesCWAroundPoint(CGPoint point, CGPoint origin)
{
    point = AGCGPointSubtract(point, origin);
    point = CGPointMake(point.y, -point.x);
    return AGCGPointAdd(point, origin);
}

extern CGPoint AGCGPointRotate90DegreesCC(CGPoint point)
{
    return AGCGPointRotate90DegreesCCAroundPoint(point, CGPointZero);
}

extern CGPoint AGCGPointRotate90DegreesCCAroundPoint(CGPoint point, CGPoint origin)
{
    point = AGCGPointSubtract(point, origin);
    point = CGPointMake(-point.y, point.x);
    return AGCGPointAdd(point, origin);
}

extern CGPoint AGCGPointConvertFromAnchorPoint(CGPoint anchor, CGRect rect)
{
    CGPoint point;
    point.x = (anchor.x * rect.size.width) + rect.origin.x;
    point.y = (anchor.y * rect.size.height) + rect.origin.y;
    return point;
}

extern CGPoint AGCGPointConvertToAnchorPoint(CGPoint point, CGRect rect)
{
    CGPoint anchor = CGPointZero;
    CGPoint minPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    anchor.x = ((point.x - minPoint.x) / rect.size.width);
    anchor.y = ((point.y - minPoint.y) / rect.size.height);
    return anchor;
}

extern CGPoint AGCGPointInterpolate(CGPoint point1, CGPoint point2, double progress)
{
    CGPoint result;
    result.x = agInterpolate(point1.x, point2.x, progress);
    result.y = agInterpolate(point1.y, point2.y, progress);
    return result;
}





#pragma mark - 
#pragma mark CGSize

extern BOOL AGCGSizeGotAnyNanValues(CGSize size)
{
    // which is better 'a == NAN' or 'a != a'?
    return size.width == NAN || size.height == NAN;
}

extern CGSize AGCGSizeModified(CGSize size, CGSize (^block)(CGSize size))
{
    return block(size);
}

extern CGSize AGCGSizeHalf(CGSize size)
{
    return CGSizeMake(size.width / 2.0, size.height / 2.0);
}

extern CGSize AGCGSizeSwitchAxis(CGSize size)
{
    return CGSizeMake(size.height, size.width);
}

extern double AGCGSizeAspectRatio(CGSize size)
{
    return size.width / size.height;
}

extern CGSize AGCGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner)
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

extern BOOL AGCGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2)
{
    double aspect1 = AGCGSizeAspectRatio(size1);
    double aspect2 = AGCGSizeAspectRatio(size2);
    return aspect1 > aspect2;
}

extern CGFloat AGCGSizeScalarToAspectFit(CGSize sizeToFit, CGSize container)
{
    CGSize sizeMultiplier = CGSizeMake(sizeToFit.width / container.width,
                                       sizeToFit.height / container.height);

    return sizeMultiplier.width < sizeMultiplier.height ? sizeMultiplier.width : sizeMultiplier.height;
}

extern CGFloat AGCGSizeScalarToAspectFill(CGSize sizeToFill, CGSize container)
{
    CGSize sizeMultiplier = CGSizeMake(sizeToFill.width / container.width,
                                       sizeToFill.height / container.height);

    return sizeMultiplier.width > sizeMultiplier.height ? sizeMultiplier.width : sizeMultiplier.height;
}

extern CGSize AGCGSizeInterpolate(CGSize size1, CGSize size2, double progress)
{
    CGSize result;
    result.width = agInterpolate(size1.width, size2.width, progress);
    result.height = agInterpolate(size1.height, size2.height, progress);
    return result;
}




#pragma mark -
#pragma mark CGRect

extern BOOL AGCGRectGotAnyNanValues(CGRect rect)
{
    return AGCGSizeGotAnyNanValues(rect.size) || AGCGPointGotAnyNanValues(rect.origin);
}

extern CGRect AGCGRectModified(CGRect rect, CGRect (^block)(CGRect rect))
{
    return block(rect);
}

CGSize AGRectGapBetween(CGRect rect1, CGRect rect2)
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

extern CGPoint AGCGRectGetMid(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect AGCGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints)
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

extern CGRect AGCGRectMakeWithSize(CGSize size)
{
    return (CGRect){CGPointZero, size};
}

extern CGRect AGCGRectWithSize(CGRect rect, CGSize newSize)
{
    rect.size = newSize;
    return rect;
}

extern CGRect AGCGRectWithWidth(CGRect rect, CGFloat newWidth)
{
    rect.size.width = newWidth;
    return rect;
}

extern CGRect AGCGRectWithHeight(CGRect rect, CGFloat newHeight)
{
    rect.size.height = newHeight;
    return rect;
}

extern CGRect AGCGRectWithOrigin(CGRect rect, CGPoint origin)
{
    rect.origin = origin;
    return rect;
}

extern CGRect AGCGRectWithOriginMinX(CGRect rect, CGFloat value)
{
    rect.origin.x = value;
    return rect;
}

extern CGRect AGCGRectWithOriginMinY(CGRect rect, CGFloat value)
{
    rect.origin.y = value;
    return rect;
}

extern CGRect AGCGRectWithOriginMaxY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - rect.size.height;
    return rect;
}

extern CGRect AGCGRectWithOriginMaxX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - rect.size.width;
    return rect;
}

extern CGRect AGCGRectWithOriginMidX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - (rect.size.width / 2.0);
    return rect;
}

extern CGRect AGCGRectWithOriginMidY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - (rect.size.height / 2.0);
    return rect;
}

extern CGRect AGCGRectWithOriginMid(CGRect rect, CGPoint origin)
{
    rect.origin.x = origin.x - (rect.size.width / 2.0);
    rect.origin.y = origin.y - (rect.size.height / 2.0);
    return rect;
}

extern CGRect AGCGRectInterpolate(CGRect rect1, CGRect rect2, double progress)
{
    CGRect result;
    result.origin = AGCGPointInterpolate(rect1.origin, rect2.origin, progress);
    result.size = AGCGSizeInterpolate(rect1.size, rect2.size, progress);
    return result;
}