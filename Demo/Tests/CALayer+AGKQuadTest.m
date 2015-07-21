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
#import "CALayer+AGKQuad.h"

@interface CALayer_AGKQuadTest : XCTestCase

@end

@implementation CALayer_AGKQuadTest

- (AGKQuad)createSampleConvexQuad
{
    AGKQuad q = AGKQuadMake(CGPointMake(150, 100),
                            CGPointMake(740, -20),
                            CGPointMake(800, 500),
                            CGPointMake(-50, 300));
    return q;
}

- (void)testQuadrilateralPropertyWithSuperlayer
{
    AGKQuad q = [self createSampleConvexQuad];

    CALayer *superlayer = [CALayer layer];

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 200, 400);
    layer.anchorPoint = CGPointZero;
    [superlayer addSublayer:layer];

    layer.quadrilateral = q;
    XCTAssertTrue(AGKQuadEqualWithAccuracy(layer.quadrilateral, q, 0.001), @"Quads not equal: %@ VS. %@", NSStringFromAGKQuad(layer.quadrilateral), NSStringFromAGKQuad(q));
}

- (void)testQuadrilateralPropertyWithoutSuperlayer
{
    AGKQuad q = [self createSampleConvexQuad];

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 200, 400);
    layer.anchorPoint = CGPointZero;

    layer.quadrilateral = q;
    XCTAssertTrue(AGKQuadEqualWithAccuracy(layer.quadrilateral, q, 0.001), @"Quads not equal: %@ VS. %@", NSStringFromAGKQuad(layer.quadrilateral), NSStringFromAGKQuad(q));
}

@end
