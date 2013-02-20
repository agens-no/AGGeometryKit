//
//  AGCornerTest.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AGCorner.h"
#import "CGGeometry+Extra.h"

@interface AGCornerTest : SenTestCase

@end

@implementation AGCornerTest

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


- (void)testAGCornerIsOnSide
{
    STAssertTrue(AGCornerIsOnSide(AGCornerTopLeft, AGSideLeft), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomLeft, AGSideLeft), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopLeft, AGSideTop), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopRight, AGSideTop), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerTopRight, AGSideRight), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomRight, AGSideRight), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomRight, AGSideBottom), @"corner should on given side");
    STAssertTrue(AGCornerIsOnSide(AGCornerBottomLeft, AGSideBottom), @"corner should on given side");
}

- (void)testCombinedUsageAnchorAndCorner
{
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerTopLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerTopRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerBottomRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80 + 270), @"point is not as expected");
    
    point = CGPointGetPointForAnchorPointInRect(AGCornerConvertToAnchorPoint(AGCornerBottomLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80 + 270), @"point is not as expected");
}

@end
