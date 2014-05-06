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
#import "AGKMath.h"
#import "pthread.h"

#pragma mark - CGPoint

extern BOOL AGKCGPointGotAnyNanValues(CGPoint origin)
{
    // which is better 'a == NAN' or 'a != a'?
    return origin.x == NAN || origin.y == NAN;
}

extern CGPoint AGKCGPointModified(CGPoint point, CGPoint (^block)(CGPoint point))
{
    return block(point);
}

extern CGPoint AGKCGPointAdd(CGPoint p1, CGPoint p2)
{
    return (CGPoint){p1.x + p2.x, p1.y + p2.y};
}

extern CGPoint AGKCGPointAddSize(CGPoint p, CGSize s)
{
    return CGPointMake(p.x + s.width, p.y + s.height);
}

extern CGPoint AGKCGPointSubtract(CGPoint p1, CGPoint p2)
{
    return (CGPoint){p1.x - p2.x, p1.y - p2.y};
}

extern CGPoint AGKCGPointMultiply(CGPoint p1, CGFloat factor)
{
    return (CGPoint){p1.x * factor, p1.y * factor};
}

extern CGPoint AGKCGPointDivide(CGPoint p1, CGFloat factor)
{
    return (CGPoint){p1.x / factor, p1.y / factor};
}

extern CGPoint AGKCGPointNormalize(CGPoint v)
{
    CGFloat length = AGKCGPointLength(v);
    if(length != 0.0)
    {
        v.x /= length;
        v.y /= length;
    }
    return v;
}

extern CGFloat AGKCGPointDotProduct(CGPoint p1, CGPoint p2)
{
    return (p1.x * p2.x) + (p1.y * p2.y);
}

extern CGFloat AGKCGPointCrossProductZComponent(CGPoint v1, CGPoint v2)
{
    return v1.x * v2.y - v1.y * v2.x;
}

extern CGFloat AGKCGPointLength(CGPoint v)
{
    return sqrtf(v.x * v.x + v.y * v.y);
}

extern CGFloat AGKCGPointLengthBetween(CGPoint p1, CGPoint p2)
{
    CGPoint p = CGPointMake(p2.x - p1.x, p2.y - p1.y);
    return sqrtf(powf(p.x, 2.0f) + powf(p.y, 2.0f));
}

CGPoint AGKCGPointApplyCATransform3D(CGPoint point,
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

extern CGPoint AGKCGPointRotate(CGPoint point, CGFloat angle)
{
    return AGKCGPointRotateAroundOrigin(point, angle, CGPointZero);
}

extern CGPoint AGKCGPointRotateAroundOrigin(CGPoint point, CGFloat angle, CGPoint origin)
{
    point = AGKCGPointSubtract(point, origin);

    CGFloat cosa = cosf(angle);
    CGFloat sina = sinf(angle);

    CGPoint r;
	r.x = point.x*cosa - point.y*sina;
	r.y = point.x*sina + point.y*cosa;

    return AGKCGPointAdd(r, origin);
}

extern CGPoint AGKCGPointRotate90DegreesCW(CGPoint point)
{
    return AGKCGPointRotate90DegreesCWAroundPoint(point, CGPointZero);
}

extern CGPoint AGKCGPointRotate90DegreesCWAroundPoint(CGPoint point, CGPoint origin)
{
    point = AGKCGPointSubtract(point, origin);
    point = CGPointMake(point.y, -point.x);
    return AGKCGPointAdd(point, origin);
}

extern CGPoint AGKCGPointRotate90DegreesCC(CGPoint point)
{
    return AGKCGPointRotate90DegreesCCAroundPoint(point, CGPointZero);
}

extern CGPoint AGKCGPointRotate90DegreesCCAroundPoint(CGPoint point, CGPoint origin)
{
    point = AGKCGPointSubtract(point, origin);
    point = CGPointMake(-point.y, point.x);
    return AGKCGPointAdd(point, origin);
}

extern CGPoint AGKCGPointConvertFromAnchorPoint(CGPoint anchor, CGRect rect)
{
    CGPoint point;
    point.x = (anchor.x * rect.size.width) + rect.origin.x;
    point.y = (anchor.y * rect.size.height) + rect.origin.y;
    return point;
}

extern CGPoint AGKCGPointConvertToAnchorPoint(CGPoint point, CGRect rect)
{
    CGPoint anchor = CGPointZero;
    CGPoint minPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    anchor.x = ((point.x - minPoint.x) / rect.size.width);
    anchor.y = ((point.y - minPoint.y) / rect.size.height);
    return anchor;
}

extern CGPoint AGKCGPointInterpolate(CGPoint point1, CGPoint point2, double progress)
{
    CGPoint result;
    result.x = AGKInterpolate(point1.x, point2.x, progress);
    result.y = AGKInterpolate(point1.y, point2.y, progress);
    return result;
}





#pragma mark - 
#pragma mark CGSize

extern BOOL AGKCGSizeGotAnyNanValues(CGSize size)
{
    // which is better 'a == NAN' or 'a != a'?
    return size.width == NAN || size.height == NAN;
}

extern CGSize AGKCGSizeModified(CGSize size, CGSize (^block)(CGSize size))
{
    return block(size);
}

extern CGSize AGKCGSizeHalf(CGSize size)
{
    return CGSizeMake(size.width / 2.0, size.height / 2.0);
}

extern CGSize AGKCGSizeSwitchAxis(CGSize size)
{
    return CGSizeMake(size.height, size.width);
}

extern double AGKCGSizeAspectRatio(CGSize size)
{
    return size.width / size.height;
}

extern CGSize AGKCGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner)
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

extern BOOL AGKCGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2)
{
    double aspect1 = AGKCGSizeAspectRatio(size1);
    double aspect2 = AGKCGSizeAspectRatio(size2);
    return aspect1 > aspect2;
}

extern CGFloat AGKCGSizeScalarToAspectFit(CGSize sizeToFit, CGSize container)
{
    CGSize sizeMultiplier = CGSizeMake(sizeToFit.width / container.width,
                                       sizeToFit.height / container.height);

    return sizeMultiplier.width < sizeMultiplier.height ? sizeMultiplier.width : sizeMultiplier.height;
}

extern CGFloat AGKCGSizeScalarToAspectFill(CGSize sizeToFill, CGSize container)
{
    CGSize sizeMultiplier = CGSizeMake(sizeToFill.width / container.width,
                                       sizeToFill.height / container.height);

    return sizeMultiplier.width > sizeMultiplier.height ? sizeMultiplier.width : sizeMultiplier.height;
}

extern CGSize AGKCGSizeInterpolate(CGSize size1, CGSize size2, double progress)
{
    CGSize result;
    result.width = AGKInterpolate(size1.width, size2.width, progress);
    result.height = AGKInterpolate(size1.height, size2.height, progress);
    return result;
}




#pragma mark -
#pragma mark CGRect

extern BOOL AGKCGRectGotAnyNanValues(CGRect rect)
{
    return AGKCGSizeGotAnyNanValues(rect.size) || AGKCGPointGotAnyNanValues(rect.origin);
}

extern CGRect AGKCGRectModified(CGRect rect, CGRect (^block)(CGRect rect))
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

extern CGPoint AGKCGRectGetMid(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect AGKCGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints)
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

extern CGRect AGKCGRectMakeWithSize(CGSize size)
{
    return (CGRect){CGPointZero, size};
}

extern CGRect AGKCGRectWithSize(CGRect rect, CGSize newSize)
{
    rect.size = newSize;
    return rect;
}

extern CGRect AGKCGRectWithWidth(CGRect rect, CGFloat newWidth)
{
    rect.size.width = newWidth;
    return rect;
}

extern CGRect AGKCGRectWithHeight(CGRect rect, CGFloat newHeight)
{
    rect.size.height = newHeight;
    return rect;
}

extern CGRect AGKCGRectWithOrigin(CGRect rect, CGPoint origin)
{
    rect.origin = origin;
    return rect;
}

extern CGRect AGKCGRectWithOriginMinX(CGRect rect, CGFloat value)
{
    rect.origin.x = value;
    return rect;
}

extern CGRect AGKCGRectWithOriginMinY(CGRect rect, CGFloat value)
{
    rect.origin.y = value;
    return rect;
}

extern CGRect AGKCGRectWithOriginMaxY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - rect.size.height;
    return rect;
}

extern CGRect AGKCGRectWithOriginMaxX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - rect.size.width;
    return rect;
}

extern CGRect AGKCGRectWithOriginMidX(CGRect rect, CGFloat value)
{
    rect.origin.x = value - (rect.size.width / 2.0);
    return rect;
}

extern CGRect AGKCGRectWithOriginMidY(CGRect rect, CGFloat value)
{
    rect.origin.y = value - (rect.size.height / 2.0);
    return rect;
}

extern CGRect AGKCGRectWithOriginMid(CGRect rect, CGPoint origin)
{
    rect.origin.x = origin.x - (rect.size.width / 2.0);
    rect.origin.y = origin.y - (rect.size.height / 2.0);
    return rect;
}

extern CGRect AGKCGRectInterpolate(CGRect rect1, CGRect rect2, double progress)
{
    CGRect result;
    result.origin = AGKCGPointInterpolate(rect1.origin, rect2.origin, progress);
    result.size = AGKCGSizeInterpolate(rect1.size, rect2.size, progress);
    return result;
}