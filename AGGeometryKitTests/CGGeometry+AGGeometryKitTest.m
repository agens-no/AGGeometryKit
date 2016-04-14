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

#import <XCTest/XCTest.h>
#import <QuartzCore/QuartzCore.h>
#import "CGGeometry+AGGeometryKit.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static double E = 0.001;

@interface AGGeometryTest : XCTestCase

@end


@implementation AGGeometryTest

- (void)testCGPointForAnchorPointInRect
{
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point = CGPointConvertFromAnchorPoint_AGK(CGPointMake(0.5, 0.8), rect);
    CGPoint expected = CGPointMake(50.0 + (350.0 * 0.5), 80 + (270 * 0.8));
    XCTAssertEqualObjects([NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:expected]);
}

- (void)testCGPointAnchorForPointInRect
{
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(250, 175);
        CGPoint anchor = CGPointConvertToAnchorPoint_AGK(point, rect);
        CGPoint expected = CGPointMake(0.5, 0.5);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:anchor], [NSValue valueWithCGPoint:expected]);
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(150, 175);
        CGPoint anchor = CGPointConvertToAnchorPoint_AGK(point, rect);
        CGPoint expected = CGPointMake(-0.5, 0.5);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:anchor], [NSValue valueWithCGPoint:expected]);
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(300, 200);
        CGPoint anchor = CGPointConvertToAnchorPoint_AGK(point, rect);
        CGPoint expected = CGPointMake(1.0, 1.0);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:anchor], [NSValue valueWithCGPoint:expected]);
    }
}

- (void)testCGPointDistance_AGK
{
    CGPoint p1, p2;
    p1 = CGPointMake(50, 40);
    p2 = CGPointMake(10, 70);
    
    XCTAssertEqual(CGPointLengthBetween_AGK(p1, p2), (CGFloat) 50.0f, @"Distance is not calculated correctly");
}

- (void)testInterpolate
{
    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(70, 60, 200, 40);
        CGRect rectp00 = CGRectInterpolate_AGK(rect1, rect2, 0.0f);
        CGRect rectp03 = CGRectInterpolate_AGK(rect1, rect2, 0.3f);
        CGRect rectp05 = CGRectInterpolate_AGK(rect1, rect2, 0.5f);
        CGRect rectp07 = CGRectInterpolate_AGK(rect1, rect2, 0.7f);
        CGRect rectp1 = CGRectInterpolate_AGK(rect1, rect2, 1.0f);
        
        XCTAssertEqualWithAccuracy(rectp00.origin.x, 10, E);
        XCTAssertEqualWithAccuracy(rectp00.origin.y, 50, E);
        XCTAssertEqualWithAccuracy(rectp00.size.width, 150, E);
        XCTAssertEqualWithAccuracy(rectp00.size.height, 100, E);
        
        XCTAssertEqualWithAccuracy(rectp03.origin.x, 28, E);
        XCTAssertEqualWithAccuracy(rectp03.origin.y, 53, E);
        XCTAssertEqualWithAccuracy(rectp03.size.width, 165, E);
        XCTAssertEqualWithAccuracy(rectp03.size.height, 82, E);
        
        XCTAssertEqualWithAccuracy(rectp05.origin.x, 40, E);
        XCTAssertEqualWithAccuracy(rectp05.origin.y, 55, E);
        XCTAssertEqualWithAccuracy(rectp05.size.width, 175, E);
        XCTAssertEqualWithAccuracy(rectp05.size.height, 70, E);
        
        XCTAssertEqualWithAccuracy(rectp07.origin.x, 52, E);
        XCTAssertEqualWithAccuracy(rectp07.origin.y, 57, E);
        XCTAssertEqualWithAccuracy(rectp07.size.width, 185, E);
        XCTAssertEqualWithAccuracy(rectp07.size.height, 58, E);
        
        XCTAssertEqualWithAccuracy(rectp1.origin.x, 70, E);
        XCTAssertEqualWithAccuracy(rectp1.origin.y, 60, E);
        XCTAssertEqualWithAccuracy(rectp1.size.width, 200, E);
        XCTAssertEqualWithAccuracy(rectp1.size.height, 40, E);
    }
    
    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(-20, 60, 200, 40);
        CGRect rectp00 = CGRectInterpolate_AGK(rect1, rect2, 0.0);
        CGRect rectp03 = CGRectInterpolate_AGK(rect1, rect2, 0.3);
        CGRect rectp1 = CGRectInterpolate_AGK(rect1, rect2, 1.0);
        
        XCTAssertEqualWithAccuracy(rectp00.origin.x, 10, E);
        XCTAssertEqualWithAccuracy(rectp00.origin.y, 50, E);
        XCTAssertEqualWithAccuracy(rectp00.size.width, 150, E);
        XCTAssertEqualWithAccuracy(rectp00.size.height, 100, E);
        
        XCTAssertEqualWithAccuracy(rectp03.origin.x, 1, E);
        XCTAssertEqualWithAccuracy(rectp03.origin.y, 53, E);
        XCTAssertEqualWithAccuracy(rectp03.size.width, 165, E);
        XCTAssertEqualWithAccuracy(rectp03.size.height, 82, E);
        
        XCTAssertEqualWithAccuracy(rectp1.origin.x, -20, E);
        XCTAssertEqualWithAccuracy(rectp1.origin.y, 60, E);
        XCTAssertEqualWithAccuracy(rectp1.size.width, 200, E);
        XCTAssertEqualWithAccuracy(rectp1.size.height, 40, E);
    }
    
}

- (void)testCGRectWith
{
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMinX_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.x, 300.0f);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMinY_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.y, 300.0f);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMidX_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.x, 225.0f);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMidY_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.y, 250.0f);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMaxX_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.x, 150.0f);
    }
    {
        CGRect rectWithALongNameOrPathSinceThatsWhenItIsUsefull = CGRectMake(40, 20, 150, 100);
        CGRect rect = CGRectWithOriginMaxY_AGK(rectWithALongNameOrPathSinceThatsWhenItIsUsefull, 300);
        XCTAssertEqual(rect.origin.y, 200.0f);
    }
}

- (void)testCGPointModifiedCATransform3D_AGK
{
    {
        CGPoint p = CGPointMake(0, 0);
        CATransform3D t = CATransform3DMakeScale(1.8, 1.4, 0.0);
        CGPoint anchorPoint = CGPointMake(0, 0);
        CGPoint retval = CGPointApplyCATransform3D_AGK(p, t, anchorPoint, CATransform3DIdentity);
        CGPoint expected = CGPointMake(0, 0);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:retval], [NSValue valueWithCGPoint:expected]);
    }
    {
        CGPoint p = CGPointMake(100, 100);
        CATransform3D t = CATransform3DMakeScale(1.8, 1.4, 0.0);
        CGPoint anchorPoint = CGPointMake(0, 0);
        CGPoint retval = CGPointApplyCATransform3D_AGK(p, t, anchorPoint, CATransform3DIdentity);
        CGPoint expected = CGPointMake(180, 140);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:retval], [NSValue valueWithCGPoint:expected]);
    }
}

- (void)testCGFloatRound_AGK
{
    XCTAssertEqual(CGFloatRound_AGK(-0.2), 0.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(0.0), 0.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(0.4), 0.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(0.5), 1.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(0.6), 1.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(1.0), 1.0, @"");
    XCTAssertEqual(CGFloatRound_AGK(1.3), 1.0, @"");
}

- (void)testCGFloatCeil_AGK
{
    XCTAssertEqual(CGFloatCeil_AGK(-0.2), 0.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(0.0), 0.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(0.4), 1.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(0.5), 1.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(0.6), 1.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(1.0), 1.0, @"");
    XCTAssertEqual(CGFloatCeil_AGK(1.3), 2.0, @"");
}

- (void)testCGFloatFloor_AGK
{
    XCTAssertEqual(CGFloatFloor_AGK(-0.2), -1.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(0.0), 0.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(0.4), 0.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(0.5), 0.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(0.6), 0.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(1.0), 1.0, @"");
    XCTAssertEqual(CGFloatFloor_AGK(1.3), 1.0, @"");
}

- (void)testCGRectFloor_AGK
{
    {
        CGRect rect = CGRectFloor_AGK(CGRectMake(40.9, 20.1, 150.0, 100.0005));
        CGRect expected = CGRectMake(40, 20, 150, 100);
        XCTAssertEqualObjects([NSValue valueWithCGRect:rect], [NSValue valueWithCGRect:expected]);
    }
}

- (void)testCGRectCeil_AGK
{
    {
        CGRect rect = CGRectCeil_AGK(CGRectMake(40.9, 20.1, 150.0, 100.0005));
        CGRect expected = CGRectMake(41, 21, 150, 101);
        XCTAssertEqualObjects([NSValue valueWithCGRect:rect], [NSValue valueWithCGRect:expected]);
    }
}

- (void)testCGRectRound_AGK
{
    {
        CGRect rect = CGRectRound_AGK(CGRectMake(40.9, 20.1, 150.0, 100.0005));
        CGRect expected = CGRectMake(41, 20, 150, 100);
        XCTAssertEqualObjects([NSValue valueWithCGRect:rect], [NSValue valueWithCGRect:expected]);
    }
}

@end
