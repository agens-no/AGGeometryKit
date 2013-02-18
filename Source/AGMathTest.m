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
        assertThatDouble(value, is(equalToDouble(170.0f)));
    }
    {
        double value = valueInterpolate(100, 200, 0.0);
        assertThatDouble(value, is(equalToDouble(100.0f)));
    }
    {
        double value = valueInterpolate(100, 200, 1.0);
        assertThatDouble(value, is(equalToDouble(200.0f)));
    }
    {
        double value = valueInterpolate(100, 200, -0.5);
        assertThatDouble(value, is(equalToDouble(50.0f)));
    }
    {
        double value = valueInterpolate(100, 200, 1.5);
        assertThatDouble(value, is(equalToDouble(250.0f)));
    }
}

- (void)testProgressForValue
{
    {
        double progress = progressForValue(100, 200, 170);
        assertThatDouble(progress, is(equalToDouble(0.7f)));
    }
    {
        double progress = progressForValue(100, 200, 100.0f);
        assertThatDouble(progress, is(equalToDouble(0.0f)));
    }
    {
        double progress = progressForValue(100, 200, 200);
        assertThatDouble(progress, is(equalToDouble(1.0f)));
    }
    {
        double progress = progressForValue(100, 200, 50);
        assertThatDouble(progress, is(equalToDouble(-0.5f)));
    }
    {
        double progress = progressForValue(100, 200, 250);
        assertThatDouble(progress, is(equalToDouble(1.5f)));
    }
}

@end
