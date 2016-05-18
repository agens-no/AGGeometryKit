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
#import <AGGeometryKit/AGKMath.h>

@interface AGKMathTest : XCTestCase

@end

@implementation AGKMathTest

- (void)testAGKInterpolate
{
    {
        CGFloat value = AGKInterpolate(100, 200, 0.7);
        XCTAssertEqualWithAccuracy(value, 170.0, FLT_EPSILON);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 0.0);
        XCTAssertEqualWithAccuracy(value, 100.0, FLT_EPSILON);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 1.0);
        XCTAssertEqualWithAccuracy(value, 200.0, FLT_EPSILON);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, -0.5);
        XCTAssertEqualWithAccuracy(value, 50.0, FLT_EPSILON);
    }
    {
        CGFloat value = AGKInterpolate(100, 200, 1.5);
        XCTAssertEqualWithAccuracy(value, 250.0, FLT_EPSILON);
    }
}

- (void)testAGKRemapToZeroOne
{
    {
        CGFloat progress = AGKRemapToZeroOne(170, 100, 200);
        XCTAssertEqualWithAccuracy(progress, 0.7, FLT_EPSILON);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(100, 100, 200);
        XCTAssertEqualWithAccuracy(progress, 0.0, FLT_EPSILON);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(200, 200, 100);
        XCTAssertEqualWithAccuracy(progress, 0.0, FLT_EPSILON);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(50, 100, 200);
        XCTAssertEqualWithAccuracy(progress, -0.5, FLT_EPSILON);
    }
    {
        CGFloat progress = AGKRemapToZeroOne(250, 100, 200);
        XCTAssertEqualWithAccuracy(progress, 1.5, FLT_EPSILON);
    }
}

- (void)testAGKRemap
{
    XCTAssertEqualWithAccuracy(AGKRemap(72, 0, 100, 0.0, 1.0), 0.72, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemap(40, 20, 60, 0.0, 1.0), 0.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemap(50, 60, 20, 0.0, 1.0), 0.25, FLT_EPSILON); // reversed input range
    XCTAssertEqualWithAccuracy(AGKRemap(50, 20, 60, 1.0, 0.0), 0.25, FLT_EPSILON); // reversed output range
    XCTAssertEqualWithAccuracy(AGKRemap(50, 60, 20, 1.0, 0.0), 0.75, FLT_EPSILON); // reversed both ranges
}

- (void)testAGKRemapAndClamp
{
    XCTAssertEqualWithAccuracy(AGKRemapAndClamp(5.0, 2.0, 3.0, 0.0, 1.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapAndClamp(4.0, 2.0, 3.0, 0.0, 1.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapAndClamp(3.0, 2.0, 3.0, 0.0, 1.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapAndClamp(2.9, 2.0, 3.0, 0.0, 1.0), 0.9, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapAndClamp(0.9, 2.0, 3.0, 0.0, 1.0), 0.0, FLT_EPSILON);
}

- (void)testAGKRemapToZeroOneAndClamp
{
    XCTAssertEqualWithAccuracy(AGKRemapToZeroOneAndClamp(5.0, 2.0, 3.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapToZeroOneAndClamp(4.0, 2.0, 3.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapToZeroOneAndClamp(3.0, 2.0, 3.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapToZeroOneAndClamp(2.9, 2.0, 3.0), 0.9, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKRemapToZeroOneAndClamp(0.9, 2.0, 3.0), 0.0, FLT_EPSILON);
}

- (void)testAGKClamp
{
    XCTAssertEqualWithAccuracy(AGKClamp(0.5, 1.0, 50.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKClamp(0.5, 0.0, 50.0), 0.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKClamp(-1.5, -2.0, -1.0), -1.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKClamp(5, -2.0, -1.0), -1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKClamp(5, 2, 7), 5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKClamp(5, -2, 3), 3, FLT_EPSILON);
}

- (void)testAGK_CLAMP
{
    XCTAssertEqualWithAccuracy(AGK_CLAMP(0.5, 1.0, 50.0), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGK_CLAMP(0.5, 0.0, 50.0), 0.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGK_CLAMP(-1.5, -2.0, -1.0), -1.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGK_CLAMP(5, -2.0, -1.0), -1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGK_CLAMP(5, 2, 7), 5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGK_CLAMP(5, -2, 3), 3, FLT_EPSILON);
}

- (void)testAGKIsWithin
{
    XCTAssertTrue(AGKIsWithin(0, -5, 2));
    XCTAssertTrue(AGKIsWithin(10.0, -5, 20.0));
    XCTAssertFalse(AGKIsWithin(2, 5, 7));
    XCTAssertFalse(AGKIsWithin(12, 5, 7));
}

- (void)testAGK_IS_WITHIN
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
    
    NSUInteger index;
    CGFloat value;
    
    value = AGKMinInArray(values, 5, &index);
    XCTAssertEqual(value, 10.0);
    XCTAssertEqual(index, 0u);
    
    value = AGKMaxInArray(values, 5, &index);
    XCTAssertEqual(value, 14.0);
    XCTAssertEqual(index, 4u);
    
    values[3] = 100;
    values[2] = -15;
    
    value = AGKMinInArray(values, 5, &index);
    XCTAssertEqual(value, -15.0);
    XCTAssertEqual(index, 2u);
    
    value = AGKMaxInArray(values, 5, &index);
    XCTAssertEqual(value, 100.0);
    XCTAssertEqual(index, 3u);
}

- (void)testMakeProgressPingPong
{
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(-1), 0.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(0.0), 0.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(0.25), 0.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(0.5), 1.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(0.75), 0.5, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(1.0), 0.0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(AGKMakeProgressPingPong(1.5), 0.0, FLT_EPSILON);
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

@end
