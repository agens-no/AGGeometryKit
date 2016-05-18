//
//  AGKBitOperationsTest.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 12.12.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AGGeometryKit/AGKBitOperations.h>

@interface AGKBitOperationsTest : XCTestCase

@end

@implementation AGKBitOperationsTest

- (void)testAGK_BIT_TEST
{
    int a = 0;
    XCTAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5));

    AGK_BIT_ENABLE(a, 1 << 5);
    XCTAssertTrue(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5));

    AGK_BIT_CLEAR(a, 1 << 5);
    XCTAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5));

    AGK_BIT_CLEAR(a, 1 << 5);
    XCTAssertFalse(AGK_BIT_TEST_ALL_ENABLED(a, 1 << 5));
}

@end
