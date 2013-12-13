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
#import "AGMath.h"

@interface AGMathTest : SenTestCase

@end

@implementation AGMathTest

- (void)testInterpolate
{
    {
        CGFloat value = agInterpolate(100, 200, 0.7);
        STAssertEquals(value, (CGFloat)170.0, nil);
    }
    {
        CGFloat value = agInterpolate(100, 200, 0.0);
        STAssertEquals(value, (CGFloat)100.0, nil);
    }
    {
        CGFloat value = agInterpolate(100, 200, 1.0);
        STAssertEquals(value, (CGFloat)200.0, nil);
    }
    {
        CGFloat value = agInterpolate(100, 200, -0.5);
        STAssertEquals(value, (CGFloat)50.0, nil);
    }
    {
        CGFloat value = agInterpolate(100, 200, 1.5);
        STAssertEquals(value, (CGFloat)250.0, nil);
    }
}

- (void)testProgressForValue
{
    {
        CGFloat progress = agRemapToZeroOne(170, 100, 200);
        STAssertEquals(progress, (CGFloat)0.7, nil);
    }
    {
        CGFloat progress = agRemapToZeroOne(100, 100, 200);
        STAssertEquals(progress, (CGFloat)0.0, nil);
    }
    {
        CGFloat progress = agRemapToZeroOne(200, 200, 100);
        STAssertTrue(progress == 0.0, nil);
    }
    {
        CGFloat progress = agRemapToZeroOne(50, 100, 200);
        STAssertEquals(progress, (CGFloat)-0.5, nil);
    }
    {
        CGFloat progress = agRemapToZeroOne(250, 100, 200);
        STAssertEquals(progress, (CGFloat)1.5, nil);
    }
}

- (void)testCLAMP
{
    STAssertEquals(AG_CLAMP(0.5, 1.0, 50.0), 1.0, nil);
    STAssertEquals(AG_CLAMP(0.5, 0.0, 50.0), 0.5, nil);
    STAssertEquals(AG_CLAMP(-1.5, -2.0, -1.0), -1.5, nil);
    STAssertEquals(AG_CLAMP(5, -2.0, -1.0), -1.0, nil);
    STAssertEquals(AG_CLAMP(5, 2, 7), 5, nil);
    STAssertEquals(AG_CLAMP(5, -2, 3), 3, nil);
}

- (void)testIS_WITHIN
{
    STAssertTrue(AG_IS_WITHIN(0, -5, 2), nil);
    STAssertTrue(AG_IS_WITHIN(10.0, -5, 20.0), nil);
    STAssertFalse(AG_IS_WITHIN(2, 5, 7), nil);
    STAssertFalse(AG_IS_WITHIN(12, 5, 7), nil);
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
    
    value = agMinInArray(values, 5, &index);
    STAssertEquals(value, (CGFloat)10.0, nil);
    STAssertEquals(index, 0u, nil);
    
    value = agMaxInArray(values, 5, &index);
    STAssertEquals(value, (CGFloat)14.0, nil);
    STAssertEquals(index, 4u, nil);
    
    values[3] = 100;
    values[2] = -15;
    
    value = agMinInArray(values, 5, &index);
    STAssertEquals(value, (CGFloat)-15.0, nil);
    STAssertEquals(index, 2u, nil);
    
    value = agMaxInArray(values, 5, &index);
    STAssertEquals(value, (CGFloat)100.0, nil);
    STAssertEquals(index, 3u, nil);
}

- (void)testMakeProgressPingPong
{
    STAssertEquals(agMakeProgressPingPong(-1), (CGFloat)0.0, nil);
    STAssertEquals(agMakeProgressPingPong(0.0), (CGFloat)0.0, nil);
    STAssertEquals(agMakeProgressPingPong(0.25), (CGFloat)0.5, nil);
    STAssertEquals(agMakeProgressPingPong(0.5), (CGFloat)1.0, nil);
    STAssertEquals(agMakeProgressPingPong(0.75), (CGFloat)0.5, nil);
    STAssertEquals(agMakeProgressPingPong(1.0), (CGFloat)0.0, nil);
    STAssertEquals(agMakeProgressPingPong(1.5), (CGFloat)0.0, nil);
}

@end
