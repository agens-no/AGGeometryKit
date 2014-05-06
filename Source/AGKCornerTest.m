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
#import "AGKCorner.h"
#import "CGGeometry+AGGeometryKit.h"

@interface AGKCornerTest : SenTestCase

@end

@implementation AGKCornerTest

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Tests


- (void)testAGKCornerIsOnSide
{
    STAssertTrue(AGKCornerIsOnSide(AGKCornerTopLeft, AGKSideLeft), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerBottomLeft, AGKSideLeft), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerTopLeft, AGKSideTop), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerTopRight, AGKSideTop), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerTopRight, AGKSideRight), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerBottomRight, AGKSideRight), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerBottomRight, AGKSideBottom), @"corner should on given side");
    STAssertTrue(AGKCornerIsOnSide(AGKCornerBottomLeft, AGKSideBottom), @"corner should on given side");
}

- (void)testCombinedUsageAnchorAndCorner
{
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = AGKCGPointConvertFromAnchorPoint(AGKCornerConvertToAnchorPoint(AGKCornerTopLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80), @"point is not as expected");
    
    point = AGKCGPointConvertFromAnchorPoint(AGKCornerConvertToAnchorPoint(AGKCornerTopRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80), @"point is not as expected");
    
    point = AGKCGPointConvertFromAnchorPoint(AGKCornerConvertToAnchorPoint(AGKCornerBottomRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80 + 270), @"point is not as expected");
    
    point = AGKCGPointConvertFromAnchorPoint(AGKCornerConvertToAnchorPoint(AGKCornerBottomLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80 + 270), @"point is not as expected");
}

@end
