//
//  AGQuadrilateralTest.m
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AGQuadrilateral.h"

@interface AGQuadrilateralTest : SenTestCase

@end

@implementation AGQuadrilateralTest

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (AGQuadrilateral)createSampleConvexQuad
{
    AGQuadrilateral q = AGQuadrilateralMakeWithCGPoints(CGPointMake(150, 100),
                                                        CGPointMake(740, -20),
                                                        CGPointMake(800, 500),
                                                        CGPointMake(-50, 300));
    return q;
}

- (AGQuadrilateral)createSampleConcaveQuad
{
    AGQuadrilateral q = AGQuadrilateralMakeWithCGPoints(CGPointMake(150, 100),
                                                        CGPointMake(740, -20),
                                                        CGPointMake(50, 120),
                                                        CGPointMake(-50, 300));
    return q;
}

#pragma mark - Tests

- (void)testAGQuadrilateralZero
{
    AGQuadrilateral zero = AGQuadrilateralZero;
    STAssertEquals(zero.tl.x, (double)0.0, nil);
    STAssertEquals(zero.tr.x, (double)0.0, nil);
    STAssertEquals(zero.br.x, (double)0.0, nil);
    STAssertEquals(zero.bl.x, (double)0.0, nil);
    STAssertEquals(zero.tl.y, (double)0.0, nil);
    STAssertEquals(zero.tr.y, (double)0.0, nil);
    STAssertEquals(zero.br.y, (double)0.0, nil);
    STAssertEquals(zero.bl.y, (double)0.0, nil);
}

- (void)testAGQuadrilateralIsValid
{
    AGQuadrilateral convexQuad = [self createSampleConvexQuad];
    STAssertTrue(AGQuadrilateralIsValid(convexQuad), nil);
    
    AGQuadrilateral concaveQuad = [self createSampleConcaveQuad];
    STAssertFalse(AGQuadrilateralIsValid(concaveQuad), nil);
}

- (void)testAGQuadrilateral
{
    {
        AGQuadrilateral q = AGQuadrilateralMakeWithCGSize(CGSizeMake(500, 500));
        AGPoint center = AGQuadrilateralGetCenter(q);
        STAssertEquals(AGPointAsCGPoint(center), CGPointMake(250, 250), nil);
    }
}

@end
