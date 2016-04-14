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
#import "CALayer+AGK+Properties.h"

@interface CALayer_AGK_PropertiesTest : XCTestCase

@end

@implementation CALayer_AGK_PropertiesTest

- (void)testBounds
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(80, 50, 400, 300);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:layer.boundsOrigin], [NSValue valueWithCGPoint:CGPointZero]);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:layer.boundsOrigin], [NSValue valueWithCGPoint:CGPointMake(0, 0)]);
    layer.boundsOrigin = CGPointMake(20, 30);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:layer.boundsOrigin], [NSValue valueWithCGPoint:CGPointMake(20, 30)]);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:layer.boundsCenter], [NSValue valueWithCGPoint:CGPointMake(200, 150)]);
    XCTAssertEqual(layer.boundsWidthHalf, 200.0);
    XCTAssertEqual(layer.boundsHeightHalf, 150.0);
    XCTAssertEqualObjects([NSValue valueWithCGSize:layer.boundsSizeHalf], [NSValue valueWithCGSize:CGSizeMake(200.0f, 150.0f)]);


    layer.boundsWidth = 500;
    XCTAssertEqualObjects([NSValue valueWithCGSize:layer.boundsSize], [NSValue valueWithCGSize:CGSizeMake(500, 300)]);
    XCTAssertEqual(layer.boundsWidth, 500);

    XCTAssertEqual(layer.boundsHeight, 300);
    layer.boundsHeight = 600;
    XCTAssertEqual(layer.boundsHeight, 600);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:layer.boundsCenter], [NSValue valueWithCGPoint:CGPointMake(250, 300)]);

    XCTAssertEqualObjects([NSValue valueWithCGSize:layer.boundsSize], [NSValue valueWithCGSize:CGSizeMake(500, 600)]);
    layer.boundsSize = CGSizeMake(123, 321);
    XCTAssertEqualObjects([NSValue valueWithCGSize:layer.boundsSize], [NSValue valueWithCGSize:CGSizeMake(123, 321)]);
}

- (void)testFrame
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectZero;

    layer.frameHeight = 300;
    layer.frameWidth = 400;
    layer.frameMaxX = 480;
    layer.frameMaxY = 350;
    
    XCTAssertEqual(layer.frameMinX, 80.0f);
    XCTAssertEqual(layer.frameMidX, 280.0f);
    XCTAssertEqual(layer.frameMaxX, 480.0f);
    XCTAssertEqual(layer.frameMinY, 50.0f);
    XCTAssertEqual(layer.frameMidY, 200.0f);
    XCTAssertEqual(layer.frameMaxY, 350.0f);
    XCTAssertEqual(layer.frameWidth, 400.0f);
    XCTAssertEqual(layer.frameHeight, 300.0f);
    XCTAssertEqual(layer.frameHeightHalf, 150.0f);
    XCTAssertEqual(layer.frameWidthHalf, 200.0f);
    XCTAssertEqual(layer.frameSizeHalf.width, 200.0f);
    XCTAssertEqual(layer.frameSizeHalf.height, 150.0);
}

@end
