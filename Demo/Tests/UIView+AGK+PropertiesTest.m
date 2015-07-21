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
#import "UIView+AGK+Properties.h"

@interface UIView_AGK_PropertiesTest : XCTestCase

@end

@implementation UIView_AGK_PropertiesTest

- (void)testBounds
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 50, 400, 300)];

    XCTAssertEqualObjects([NSValue valueWithCGPoint:view.boundsOrigin], [NSValue valueWithCGPoint:CGPointZero]);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:view.boundsOrigin], [NSValue valueWithCGPoint:CGPointMake(0, 0)]);
    view.boundsOrigin = CGPointMake(20, 30);
    XCTAssertEqualObjects([NSValue valueWithCGPoint:view.boundsOrigin], [NSValue valueWithCGPoint:CGPointMake(20, 30)]);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:view.boundsCenter], [NSValue valueWithCGPoint:CGPointMake(200, 150)]);
    XCTAssertEqual(view.boundsWidthHalf, 200);
    XCTAssertEqual(view.boundsHeightHalf, 150);
    XCTAssertEqualObjects([NSValue valueWithCGSize:view.boundsSizeHalf], [NSValue valueWithCGSize:CGSizeMake(200, 150)]);
    
    view.boundsWidth = 500;
    XCTAssertEqualObjects([NSValue valueWithCGSize:view.boundsSize], [NSValue valueWithCGSize:CGSizeMake(500, 300)]);
    XCTAssertEqual(view.boundsWidth, 500);

    XCTAssertEqual(view.boundsHeight, 300);
    view.boundsHeight = 600;
    XCTAssertEqual(view.boundsHeight, 600);

    XCTAssertEqualObjects([NSValue valueWithCGPoint:view.boundsCenter], [NSValue valueWithCGPoint:CGPointMake(250, 300)]);

    XCTAssertEqualObjects([NSValue valueWithCGSize:view.boundsSize], [NSValue valueWithCGSize:CGSizeMake(500, 600)]);
    view.boundsSize = CGSizeMake(123, 321);
    XCTAssertEqualObjects([NSValue valueWithCGSize:view.boundsSize], [NSValue valueWithCGSize:CGSizeMake(123, 321)]);

}

- (void)testFrame
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    v.frameHeight = 300;
    v.frameWidth = 400;
    v.frameMaxX = 480;
    v.frameMaxY = 350;
    
    XCTAssertEqual(v.frameMinX, 80);
    XCTAssertEqual(v.frameMidX, 280);
    XCTAssertEqual(v.frameMaxX, 480);
    XCTAssertEqual(v.frameMinY, 50);
    XCTAssertEqual(v.frameMidY, 200);
    XCTAssertEqual(v.frameMaxY, 350);
    XCTAssertEqual(v.frameWidth, 400);
    XCTAssertEqual(v.frameHeight, 300);
    XCTAssertEqual(v.frameWidthHalf, 200);
    XCTAssertEqual(v.frameHeightHalf, 150);
    XCTAssertEqual(v.frameSizeHalf.width, 200.0);
    XCTAssertEqual(v.frameSizeHalf.height, 150);
}

@end
