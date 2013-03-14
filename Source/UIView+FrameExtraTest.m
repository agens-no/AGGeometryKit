//
//  UIView+FrameExtraTest.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 14.03.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UIView+FrameExtra.h"

@interface UIView_FrameExtraTest : SenTestCase

@end

@implementation UIView_FrameExtraTest

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

- (void)testBounds
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(80, 50, 400, 300)];
    
    STAssertEquals(v.boundsOrigin, CGPointZero, nil);
    
    v.boundsOrigin = CGPointMake(20, 30);
    STAssertEquals(v.boundsOrigin, CGPointMake(20, 30), nil);
    STAssertEquals(v.frame.origin, CGPointMake(80, 50), nil);
    
    STAssertEquals(v.boundsCenter, CGPointMake(200, 150), nil);
    STAssertEquals(v.boundsWidthHalf, 200.0f, nil);
    STAssertEquals(v.boundsHeightHalf, 150.0f, nil);
    
    v.boundsWidth = 500;
    STAssertEquals(v.boundsSize, CGSizeMake(500, 300), nil);
    STAssertEquals(v.boundsWidth, 500.0f, nil);
    
    v.boundsHeight = 600;
    STAssertEquals(v.boundsHeight, 600.0f, nil);
}

- (void)testFrame
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    v.frameHeight = 300;
    v.frameWidth = 400;
    v.frameMaxX = 480;
    v.frameMaxY = 350;
    
    STAssertEquals(v.frameMinX, 80.0f, nil);
    STAssertEquals(v.frameMidX, 280.0f, nil);
    STAssertEquals(v.frameMaxX, 480.0f, nil);
    STAssertEquals(v.frameMinY, 50.0f, nil);
    STAssertEquals(v.frameMidY, 200.0f, nil);
    STAssertEquals(v.frameMaxY, 350.0f, nil);
    STAssertEquals(v.frameWidth, 400.0f, nil);
    STAssertEquals(v.frameHeight, 300.0f, nil);
}

@end
