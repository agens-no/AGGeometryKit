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
#import "AGKQuad.h"

@interface AGKQuadTest : XCTestCase

@end

@implementation AGKQuadTest

- (AGKQuad)createSampleConvexQuad
{
    AGKQuad q = AGKQuadMake(CGPointMake(150, 100),
                            CGPointMake(740, -20),
                            CGPointMake(800, 500),
                            CGPointMake(-50, 300));
    return q;
}

- (AGKQuad)createSampleConcaveQuad
{
    AGKQuad q = AGKQuadMake(CGPointMake(150, 100),
                            CGPointMake(740, -20),
                            CGPointMake(50, 120),
                            CGPointMake(-50, 300));
    return q;
}

#pragma mark - Tests

- (void)testAGKQuadZero
{
    AGKQuad zero = AGKQuadZero;
    XCTAssertEqual(zero.tl.x, (CGFloat)0.0);
    XCTAssertEqual(zero.tr.x, (CGFloat)0.0);
    XCTAssertEqual(zero.br.x, (CGFloat)0.0);
    XCTAssertEqual(zero.bl.x, (CGFloat)0.0);
    XCTAssertEqual(zero.tl.y, (CGFloat)0.0);
    XCTAssertEqual(zero.tr.y, (CGFloat)0.0);
    XCTAssertEqual(zero.br.y, (CGFloat)0.0);
    XCTAssertEqual(zero.bl.y, (CGFloat)0.0);
}

- (void)testAGKQuadEqual
{
    AGKQuad q1 = [self createSampleConvexQuad];
    AGKQuad q2 = [self createSampleConvexQuad];

    XCTAssertTrue(AGKQuadEqual(q1, q2));

    q2.br.x = 10;
    XCTAssertFalse(AGKQuadEqual(q1, q2));
}

- (void)testAGKQuadEqualWithAccuracy
{
    AGKQuad q1 = [self createSampleConvexQuad];
    AGKQuad q2 = [self createSampleConvexQuad];

    XCTAssertTrue(AGKQuadEqualWithAccuracy(q1, q2, 1000.0));
    XCTAssertTrue(AGKQuadEqualWithAccuracy(q1, q2, 1.0000));
    XCTAssertTrue(AGKQuadEqualWithAccuracy(q1, q2, 0.0001));

    q2.bl.y += 0.0001;
    XCTAssertTrue(AGKQuadEqualWithAccuracy(q1, q2, 0.0001));

    q2.bl.y += 0.0001;
    XCTAssertFalse(AGKQuadEqualWithAccuracy(q1, q2, 0.0001));

    q2.bl.y += 0.1;
    XCTAssertFalse(AGKQuadEqualWithAccuracy(q1, q2, 0.1));

    q2.bl.y += 1000.0;
    XCTAssertFalse(AGKQuadEqualWithAccuracy(q1, q2, 1000.0));
}

- (void)testAGKQuadContainsValidValues
{
    AGKQuad quadWithInfinityValue = [self createSampleConvexQuad];
    XCTAssertTrue(AGKQuadContainsValidValues(quadWithInfinityValue));

    quadWithInfinityValue.tr.x = CGFLOAT_MAX * 2.0;
    XCTAssertFalse(AGKQuadContainsValidValues(quadWithInfinityValue));

    AGKQuad quadWithNanValue;
    quadWithNanValue.br.y = 0.0 / 0.0;
    XCTAssertFalse(AGKQuadContainsValidValues(quadWithNanValue));
}

- (void)testAGKQuadIsValid
{
    AGKQuad convexQuad = [self createSampleConvexQuad];
    XCTAssertTrue(AGKQuadIsValid(convexQuad));
    
    AGKQuad concaveQuad = [self createSampleConcaveQuad];
    XCTAssertFalse(AGKQuadIsValid(concaveQuad));

    AGKQuad quadWithNanValue;
    quadWithNanValue.br.y = 0.0 / 0.0;
    XCTAssertFalse(AGKQuadContainsValidValues(quadWithNanValue));
}

- (void)testAGKQuadGetCenter
{
    {
        AGKQuad q = AGKQuadMakeWithCGSize(CGSizeMake(500, 500));
        CGPoint center = AGKQuadGetCenter(q);
        XCTAssertEqualObjects([NSValue valueWithCGPoint:center], [NSValue valueWithCGPoint:CGPointMake(250, 250)]);
    }
}

@end
