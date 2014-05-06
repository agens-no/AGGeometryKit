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
#import "UIView+AGK+Properties.h"

@interface UIView_AGK_PropertiesTest : SenTestCase

@end

@implementation UIView_AGK_PropertiesTest

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

- (void)testBounds
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(80, 50, 400, 300)];
    
    STAssertEquals(v.boundsOrigin, CGPointZero, nil);
    
    v.boundsOrigin = CGPointMake(20, 30);
    STAssertEquals(v.boundsOrigin, CGPointMake(20, 30), nil);
    STAssertEquals(v.frame.origin, CGPointMake(80, 50), nil);
    
    STAssertEquals(v.boundsCenter, CGPointMake(200, 150), nil);
    STAssertEquals(v.boundsWidthHalf, 200.0f, nil);
    STAssertEquals(v.boundsHeightHalf, 150.0f, nil);
    STAssertEquals(v.boundsSizeHalf, CGSizeMake(200.0f, 150.0f), nil);
    
    v.boundsWidth = 500;
    STAssertEquals(v.boundsSize, CGSizeMake(500, 300), nil);
    STAssertEquals(v.boundsWidth, 500.0f, nil);
    
    v.boundsHeight = 600;
    STAssertEquals(v.boundsHeight, 600.0f, nil);
}

- (void)testFrame
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    v.frameHeight = 300;
    v.frameWidth = 400;
    v.frameMaxX = 480;
    v.frameMaxY = 350;
    
    STAssertEquals(v.frameMinX, 80.0f, nil);
    STAssertEquals(v.frameMidX, 280.0f, nil);
    STAssertEquals(v.frameMaxX, 480.0f, nil);
    STAssertEquals(v.frameMinY, 50.0f, nil);
    STAssertEquals(v.frameMidY, 200.0f, nil);
    STAssertEquals(v.frameMaxY, 350.0f, nil);
    STAssertEquals(v.frameWidth, 400.0f, nil);
    STAssertEquals(v.frameHeight, 300.0f, nil);
    STAssertEquals(v.frameHeightHalf, 150.0f, nil);
    STAssertEquals(v.frameWidthHalf, 200.0f, nil);
    STAssertEquals(v.frameSizeHalf, CGSizeMake(200.0f, 150.0f), nil);
}

@end
