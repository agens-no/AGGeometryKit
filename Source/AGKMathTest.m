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
#import "AGKMath.h"

@interface AGKMathTest : XCTestCase

@end

@implementation AGKMathTest

- (void)testInterpolate
{
    {
        CGFloat value = AGKInterpolate(100, 200, 0.7);
        XCTAssertEqual(value, (CGFloat)170.0);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 0.0);
        XCTAssertEqual(value, (CGFloat)100.0);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 1.0);
        XCTAssertEqual(value, (CGFloat)200.0);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, -0.5);
        XCTAssertEqual(value, (CGFloat)50.0);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 1.5);
        XCTAssertEqual(value, (CGFloat)250.0);
    }
}

- (void)testProgressForValue
{
    {
        CGFloat progress = AGKRemapToZeroOne(170, 100, 200);
        XCTAssertEqual(progress, (CGFloat)0.7);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(100, 100, 200);
        XCTAssertEqual(progress, (CGFloat)0.0);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(200, 200, 100);
        XCTAssertTrue(progress == 0.0);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(50, 100, 200);
        XCTAssertEqual(progress, (CGFloat)-0.5);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(250, 100, 200);
        XCTAssertEqual(progress, (CGFloat)1.5);
    }
}

- (void)testCLAMP
{
    XCTAssertEqual(AGK_CLAMP(0.5, 1.0, 50.0), 1.0);
    XCTAssertEqual(AGK_CLAMP(0.5, 0.0, 50.0), 0.5);
    XCTAssertEqual(AGK_CLAMP(-1.5, -2.0, -1.0), -1.5);
    XCTAssertEqual(AGK_CLAMP(5, -2.0, -1.0), -1.0);
    XCTAssertEqual(AGK_CLAMP(5, 2, 7), 5);
    XCTAssertEqual(AGK_CLAMP(5, -2, 3), 3);
}

- (void)testIS_WITHIN
{
    XCTAssertTrue(AGK_IS_WITHIN(0, -5, 2));
    XCTAssertTrue(AGK_IS_WITHIN(10.0, -5, 20.0));
    XCTAssertFalse(AGK_IS_WITHIN(2, 5, 7));
    XCTAssertFalse(AGK_IS_WITHIN(12, 5, 7));
}

- (void)testMinInArray_maxInArray
{
    CGFloat values[5];

    for(int i = 0; i < 5; i++)
    {
        values[i] = i + 10;
    }
    
    unsigned int index;
    CGFloat value;
    
    value = AGKMinInArray(values, 5, &index);
    XCTAssertEqual(value, (CGFloat)10.0);
    XCTAssertEqual(index, 0u);
    
    value = AGKMaxInArray(values, 5, &index);
    XCTAssertEqual(value, (CGFloat)14.0);
    XCTAssertEqual(index, 4u);
    
    values[3] = 100;
    values[2] = -15;
    
    value = AGKMinInArray(values, 5, &index);
    XCTAssertEqual(value, (CGFloat)-15.0);
    XCTAssertEqual(index, 2u);
    
    value = AGKMaxInArray(values, 5, &index);
    XCTAssertEqual(value, (CGFloat)100.0);
    XCTAssertEqual(index, 3u);
}

- (void)testMakeProgressPingPong
{
    XCTAssertEqual(AGKMakeProgressPingPong(-1), (CGFloat)0.0);
    XCTAssertEqual(AGKMakeProgressPingPong(0.0), (CGFloat)0.0);
    XCTAssertEqual(AGKMakeProgressPingPong(0.25), (CGFloat)0.5);
    XCTAssertEqual(AGKMakeProgressPingPong(0.5), (CGFloat)1.0);
    XCTAssertEqual(AGKMakeProgressPingPong(0.75), (CGFloat)0.5);
    XCTAssertEqual(AGKMakeProgressPingPong(1.0), (CGFloat)0.0);
    XCTAssertEqual(AGKMakeProgressPingPong(1.5), (CGFloat)0.0);
}

- (void)testFloatToDoubleZeroFill
{
    double doubleValue = 1.256250;
    float floatValue = doubleValue;

    XCTAssertEqual(AGKFloatToDoubleZeroFill(M_PI), 3.141593000000);
    XCTAssertEqual(AGKFloatToDoubleZeroFill(floatValue), doubleValue);
    XCTAssertEqual(AGKFloatToDoubleZeroFill(0.5), 0.5);
    XCTAssertEqual(AGKFloatToDoubleZeroFill(1.0f / 3.0f), 0.333333000);
}

//- (void)testPerformanceOfFloatToDoubleZeroFill
//{
//    NSTimeInterval then = CACurrentMediaTime();
//    const int iterations = 10000;
//    for(int i = 0; i < iterations; i++)
//    {
//        AGKFloatToDoubleZeroFill(M_PI);
//    }
//    NSTimeInterval now = CACurrentMediaTime();
//    NSTimeInterval diff = now - then;
//    XCTAssertTrue(diff < 1.0 / 60.0, @"Performance is too bad on float to double conversion. Time used on %d iterations: %f", iterations, diff);
//}

@end
