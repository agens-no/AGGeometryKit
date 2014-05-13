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

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

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

- (void)testAGKQuadIsValid
{
    AGKQuad convexQuad = [self createSampleConvexQuad];
    XCTAssertTrue(AGKQuadIsValid(convexQuad));
    
    AGKQuad concaveQuad = [self createSampleConcaveQuad];
    XCTAssertFalse(AGKQuadIsValid(concaveQuad));
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
