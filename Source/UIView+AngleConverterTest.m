//
//  UIView+AngleConverterTest.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 14.03.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UIView+AngleConverter.h"

@interface UIView_AngleConverterTest : SenTestCase

@end

@implementation UIView_AngleConverterTest

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

- (void)testBasicFunctionality
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    UIView *s = [[UIView alloc] initWithFrame:v.bounds];
    [v addSubview:s];
    
    s.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    STAssertEqualsWithAccuracy([s convertAngleOfViewInRelationToView:v], (CGFloat)-M_PI_4, 0.000001, nil);
    STAssertEqualsWithAccuracy([s convertAngle:0.5 toView:v], (CGFloat)-M_PI_4 - 0.5f, 0.000001, nil);
}

@end
