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
#import "UIView+AGK+AngleConverter.h"

@interface UIView_AngleConverterTest : XCTestCase

@end

@implementation UIView_AngleConverterTest

- (void)testAngleConverterWithSubviews
{
    UIView *superview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    UIView *subview = [[UIView alloc] initWithFrame:superview.bounds];
    [superview addSubview:subview];
    
    subview.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    XCTAssertEqualWithAccuracy([subview convertAngleOfViewInRelationToView:superview], -M_PI_4, FLT_EPSILON);
    XCTAssertEqualWithAccuracy([subview convertAngle:0.5 toView:superview], -M_PI_4 - 0.5, 0.0001);
}

- (void)testAngleConverterWithTwoViewsInSameSuperview
{
    UIView *superview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view1.transform = CGAffineTransformMakeRotation(0.7);
    [superview addSubview:view1];

    UIView *view2 = [[UIView alloc] initWithFrame:view1.bounds];
    view2.transform = CGAffineTransformMakeRotation(0.4);
    [superview addSubview:view2];

    XCTAssertEqualWithAccuracy([view2 convertAngleOfViewInRelationToView:view1], 0.3, FLT_EPSILON);
    XCTAssertEqualWithAccuracy([view2 convertAngle:0.0 toView:view1], 0.3, FLT_EPSILON);
    XCTAssertEqualWithAccuracy([view2 convertAngle:0.5 toView:view1], 0.8, FLT_EPSILON);
}

@end
