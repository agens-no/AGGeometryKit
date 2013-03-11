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
#import "AGCorner.h"
#import "CGGeometry+Extra.h"

@interface AGCornerTest : SenTestCase

@end

@implementation AGCornerTest

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


- (void)testAGCornerIsOnSide
{
    STAssertTrue(AGCornerIsOnSide(AGCornerTopLeft, AGSideLeft), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomLeft, AGSideLeft), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopLeft, AGSideTop), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopRight, AGSideTop), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopRight, AGSideRight), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomRight, AGSideRight), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomRight, AGSideBottom), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomLeft, AGSideBottom), @"corner should on given side");
}

- (void)testCombinedUsageAnchorAndCorner
{
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerTopLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerTopRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerBottomRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80 + 270), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerBottomLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80 + 270), @"point is not as expected");
}

@end
