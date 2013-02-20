//
//  AGQuadTest.m
//  AGQuad
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AGQuad.h"

@interface AGQuadTest : SenTestCase

@end

@implementation AGQuadTest

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (AGQuad)createSampleConvexQuad
{
    AGQuad q = AGQuadMakeWithCGPoints(CGPointMake(150, 100),
                                      CGPointMake(740, -20),
                                      CGPointMake(800, 500),
                                      CGPointMake(-50, 300));
    return q;
}

- (AGQuad)createSampleConcaveQuad
{
    AGQuad q = AGQuadMakeWithCGPoints(CGPointMake(150, 100),
                                      CGPointMake(740, -20),
                                      CGPointMake(50, 120),
                                      CGPointMake(-50, 300));
    return q;
}

#pragma mark - Tests

- (void)testAGQuadZero
{
    AGQuad zero = AGQuadZero;
    STAssertEquals(zero.tl.x, (double)0.0, nil);
    STAssertEquals(zero.tr.x, (double)0.0, nil);
    STAssertEquals(zero.br.x, (double)0.0, nil);
    STAssertEquals(zero.bl.x, (double)0.0, nil);
    STAssertEquals(zero.tl.y, (double)0.0, nil);
    STAssertEquals(zero.tr.y, (double)0.0, nil);
    STAssertEquals(zero.br.y, (double)0.0, nil);
    STAssertEquals(zero.bl.y, (double)0.0, nil);
}

- (void)testAGQuadIsValid
{
    AGQuad convexQuad = [self createSampleConvexQuad];
    STAssertTrue(AGQuadIsValid(convexQuad), nil);
    
    AGQuad concaveQuad = [self createSampleConcaveQuad];
    STAssertFalse(AGQuadIsValid(concaveQuad), nil);
}

- (void)testAGQuadGetCenter
{
    {
        AGQuad q = AGQuadMakeWithCGSize(CGSizeMake(500, 500));
        AGPoint center = AGQuadGetCenter(q);
        STAssertEquals(AGPointAsCGPoint(center), CGPointMake(250, 250), nil);
    }
}

@end
