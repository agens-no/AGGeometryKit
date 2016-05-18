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
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AGGeometryKit/AGKCorner.h>
#import "CGGeometry+AGGeometryKit.h"

@interface AGKCornerTest : XCTestCase

@end

@implementation AGKCornerTest

- (void)testAGKCornerIsOnSide
{
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerTopLeft, AGKSideLeft), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerBottomLeft, AGKSideLeft), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerTopLeft, AGKSideTop), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerTopRight, AGKSideTop), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerTopRight, AGKSideRight), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerBottomRight, AGKSideRight), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerBottomRight, AGKSideBottom), @"corner should on given side");
    XCTAssertTrue(AGKCornerIsOnSide(AGKCornerBottomLeft, AGKSideBottom), @"corner should on given side");
}

- (void)testCombinedUsageAnchorAndCorner
{
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = CGPointConvertFromAnchorPoint_AGK(AGKCornerConvertToAnchorPoint(AGKCornerTopLeft), rect);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:CGPointMake(50, 80)]);
    
    point = CGPointConvertFromAnchorPoint_AGK(AGKCornerConvertToAnchorPoint(AGKCornerTopRight), rect);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:CGPointMake(50 + 350, 80)]);
    
    point = CGPointConvertFromAnchorPoint_AGK(AGKCornerConvertToAnchorPoint(AGKCornerBottomRight), rect);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:CGPointMake(50 + 350, 80 + 270)]);
    
    point = CGPointConvertFromAnchorPoint_AGK(AGKCornerConvertToAnchorPoint(AGKCornerBottomLeft), rect);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:CGPointMake(50, 80 + 270)]);
}

@end
