//
//  AGMathTest.m
//  VG
//
//  Created by Håvard Fossli on 24.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AGMath.h"

@interface AGMathTest : SenTestCase

@end

@implementation AGMathTest

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

- (void)testValueInterpolate
{
    {
        double value = valueInterpolate(100, 200, 0.7);
        STAssertEquals(value, 170.0, nil);
    }
    {
        double value = valueInterpolate(100, 200, 0.0);
        STAssertEquals(value, 100.0, nil);
    }
    {
        double value = valueInterpolate(100, 200, 1.0);
        STAssertEquals(value, 200.0, nil);
    }
    {
        double value = valueInterpolate(100, 200, -0.5);
        STAssertEquals(value, 50.0, nil);
    }
    {
        double value = valueInterpolate(100, 200, 1.5);
        STAssertEquals(value, 250.0, nil);
    }
}

- (void)testProgressForValue
{
    {
        double progress = progressForValue(100, 200, 170);
        STAssertEquals(progress, 0.7, nil);
    }
    {
        double progress = progressForValue(100, 200, 100.0f);
        STAssertEquals(progress, 0.0, nil);
    }
    {
        double progress = progressForValue(100, 200, 200);
        STAssertEquals(progress, 1.0, nil);
    }
    {
        double progress = progressForValue(100, 200, 50);
        STAssertEquals(progress, -0.5, nil);
    }
    {
        double progress = progressForValue(100, 200, 250);
        STAssertEquals(progress, 1.5, nil);
    }
}

- (void)testBIT
{
    int a = 0;
    STAssertFalse(BIT_TEST(a, 1 << 5), nil);
    
    BIT_SET(a, 1 << 5);
    STAssertTrue(BIT_TEST(a, 1 << 5), nil);
    
    BIT_CLEAR(a, 1 << 5);
    STAssertFalse(BIT_TEST(a, 1 << 5), nil);
}

- (void)testCLAMP
{
    STAssertEquals(CLAMP(0.5, 1.0, 50.0), 1.0, nil);
    STAssertEquals(CLAMP(0.5, 0.0, 50.0), 0.5, nil);
    STAssertEquals(CLAMP(-1.5, -2.0, -1.0), -1.5, nil);
    STAssertEquals(CLAMP(5, -2.0, -1.0), -1.0, nil);
    STAssertEquals(CLAMP(5, 2, 7), 5, nil);
    STAssertEquals(CLAMP(5, -2, 3), 3, nil);
}

- (void)testIS_WITHIN
{
    STAssertTrue(IS_WITHIN(0, -5, 2), nil);
    STAssertTrue(IS_WITHIN(10.0, -5, 20.0), nil);
    STAssertFalse(IS_WITHIN(2, 5, 7), nil);
    STAssertFalse(IS_WITHIN(12, 5, 7), nil);
}

- (void)testMinInArray_maxInArray
{
    double values[5];

    for(int i = 0; i < 5; i++)
    {
        values[i] = i + 10;
    }
    
    unsigned int index;
    double value;
    
    value = minInArray(values, 5, &index);
    STAssertEquals(value, 10.0, nil);
    STAssertEquals(index, 0u, nil);
    
    value = maxInArray(values, 5, &index);
    STAssertEquals(value, 14.0, nil);
    STAssertEquals(index, 4u, nil);
    
    values[3] = 100;
    values[2] = -15;
    
    value = minInArray(values, 5, &index);
    STAssertEquals(value, -15.0, nil);
    STAssertEquals(index, 2u, nil);
    
    value = maxInArray(values, 5, &index);
    STAssertEquals(value, 100.0, nil);
    STAssertEquals(index, 3u, nil);
}

- (void)testFloatToDoubleZeroFill
{
    STAssertEquals(floatToDoubleZeroFill((double)0.5f), 0.5, nil);
    STAssertEquals(floatToDoubleZeroFill(1.0f / 3.0f), 0.333333, nil);
}

@end
