//
//  AGBitOperationsTest.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 12.12.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AGKBitOperations.h"

@interface AGBitOperationsTest : SenTestCase

@end

@implementation AGBitOperationsTest

- (void)testAGK_BIT_TEST
{
    int a = 0;
    STAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5), nil);

    AGK_BIT_ENABLE(a, 1 << 5);
    STAssertTrue(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5), nil);

    AGK_BIT_CLEAR(a, 1 << 5);
    STAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5), nil);

    AGK_BIT_CLEAR(a, 1 << 5);
    STAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5), nil);
}

@end
