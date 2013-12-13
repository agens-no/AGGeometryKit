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

#import <SenTestingKit/SenTestingKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CGGeometry+AGGeometryKit.h"

@interface AGGeometryTest : SenTestCase

@end


@implementation AGGeometryTest

- (void)testCGPointForAnchorPointInRect
{    
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = AGCGPointConvertFromAnchorPoint(CGPointMake(0.5, 0.8), rect);
    STAssertEquals(point, CGPointMake(50.0 + (350.0 * 0.5), 80 + (270 * 0.8)), @"point is not as expected");
}

- (void)testCGPointAnchorForPointInRect
{
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(250, 175);
        CGPoint anchor = AGCGPointConvertToAnchorPoint(point, rect);
        STAssertEquals(anchor, CGPointMake(0.5, 0.5), @"anchor is not as expected");
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(150, 175);
        CGPoint anchor = AGCGPointConvertToAnchorPoint(point, rect);
        STAssertEquals(anchor, CGPointMake(-0.5, 0.5), @"anchor is not as expected");
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(300, 200);
        CGPoint anchor = AGCGPointConvertToAnchorPoint(point, rect);
        STAssertEquals(anchor, CGPointMake(1.0, 1.0), @"anchor is not as expected");
    }
}

- (void)testAGCGPointDistance
{
    CGPoint p1, p2;
    p1 = CGPointMake(50, 40);
    p2 = CGPointMake(10, 70);
    
    STAssertEquals(AGCGPointLengthBetween(p1, p2), (CGFloat) 50.0f, @"Distance is not calculated correctly");
}

- (void)testInterpolate
{

    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(70, 60, 200, 40);
        CGRect rectp00 = AGCGRectInterpolate(rect1, rect2, 0.0f);
        CGRect rectp03 = AGCGRectInterpolate(rect1, rect2, 0.3f);
        CGRect rectp05 = AGCGRectInterpolate(rect1, rect2, 0.5f);
        CGRect rectp07 = AGCGRectInterpolate(rect1, rect2, 0.7f);
        CGRect rectp1 = AGCGRectInterpolate(rect1, rect2, 1.0f);
        
        STAssertEquals(rectp00, CGRectMake(10.0f, 50.0f, 150.0f, 100.0f), @"Unecpexted");
        STAssertEquals(rectp03, CGRectMake(28.0f, 53.0f, 165.0f, 82.0f), @"Unecpexted");
        STAssertEquals(rectp05, CGRectMake(40.0f, 55.0f, 175.0f, 70.0f), @"Unecpexted");
        STAssertEquals(rectp07, CGRectMake(52.0f, 57.0f, 185.0f, 58.0f), @"Unecpexted");
        STAssertEquals(rectp1, CGRectMake(70.0f, 60.0f, 200.0f, 40.0f), @"Unecpexted");
    }
    
    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(-20, 60, 200, 40);
        CGRect rectp00 = AGCGRectInterpolate(rect1, rect2, 0.0);
        CGRect rectp03 = AGCGRectInterpolate(rect1, rect2, 0.3);
        CGRect rectp1 = AGCGRectInterpolate(rect1, rect2, 1.0);
        
        STAssertEquals(rectp00, CGRectMake(10.0f, 50.0f, 150.0f, 100.0f), @"Unecpexted");
        STAssertEquals(rectp03, CGRectMake(1.0f, 53.0f, 165.0f, 82.0f), @"Unecpexted");
        STAssertEquals(rectp1, CGRectMake(-20.0f, 60.0f, 200.0f, 40.0f), @"Unecpexted");
    }

}

- (void)testCGRectWith
{
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMinX(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.x, 300.0f, nil);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMinY(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.y, 300.0f, nil);
    }
    
    
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMidX(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.x, 225.0f, nil);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMidY(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.y, 250.0f, nil);
    }
    
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMaxX(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.x, 150.0f, nil);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = AGCGRectWithOriginMaxY(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        STAssertEquals(rect.origin.y, 200.0f, nil);
    }
}

- (void)testAGCGPointModifiedCATransform3D
{
    {
        CGPoint p = CGPointMake(0, 0);
        CATransform3D t = CATransform3DMakeScale(1.8, 1.4, 0.0);
        CGPoint anchorPoint = CGPointMake(0, 0);
        CGPoint retval = AGCGPointApplyCATransform3D(p, t, anchorPoint, CATransform3DIdentity);
        CGPoint correct = CGPointMake(0, 0);
        STAssertEquals(retval, correct, nil);
    }
    {
        CGPoint p = CGPointMake(100, 100);
        CATransform3D t = CATransform3DMakeScale(1.8, 1.4, 0.0);
        CGPoint anchorPoint = CGPointMake(0, 0);
        CGPoint retval = AGCGPointApplyCATransform3D(p, t, anchorPoint, CATransform3DIdentity);
        CGPoint correct = CGPointMake(180, 140);
        STAssertEquals(retval, correct, nil);
    }
}

@end
