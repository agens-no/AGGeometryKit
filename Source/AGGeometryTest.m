//
//  AGGeometryTest.m
//  no.agens.foldshadow
//
//  Created by Håvard Fossli on 16.08.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AGGeometry.h"

@interface AGGeometryTest : SenTestCase

@end


@implementation AGGeometryTest

- (void)testVGCornerIsOnSide
{
    STAssertTrue(VGCornerIsOnSide(VGCornerTopLeft, VGSideLeft), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerBottomLeft, VGSideLeft), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerTopLeft, VGSideTop), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerTopRight, VGSideTop), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerTopRight, VGSideRight), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerBottomRight, VGSideRight), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerBottomRight, VGSideBottom), @"corner should on given side");
    STAssertTrue(VGCornerIsOnSide(VGCornerBottomLeft, VGSideBottom), @"corner should on given side");
}

- (void)testCGPointForAnchorPointInRect
{
    
    CGRect rect = CGRectMake(50, 80, 350, 270);
    CGPoint point;
    
    point = CGPointForAnchorPointInRect(CGPointMake(0.5, 0.8), rect);
    STAssertEquals(point, CGPointMake(50.0 + (350.0 * 0.5), 80 + (270 * 0.8)), @"point is not as expected");
}

- (void)testCGPointAnchorForPointInRect
{
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(250, 175);
        CGPoint anchor = CGPointAnchorForPointInRect(point, rect);
        STAssertEquals(anchor, CGPointMake(0.5, 0.5), @"anchor is not as expected");
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(150, 175);
        CGPoint anchor = CGPointAnchorForPointInRect(point, rect);
        STAssertEquals(anchor, CGPointMake(-0.5, 0.5), @"anchor is not as expected");
    }
    {
        CGRect rect = CGRectMake(200, 150, 100, 50);
        CGPoint point = CGPointMake(300, 200);
        CGPoint anchor = CGPointAnchorForPointInRect(point, rect);
        STAssertEquals(anchor, CGPointMake(1.0, 1.0), @"anchor is not as expected");
    }
}

- (void)testCombinedUsageAnchorAndCorner
{
    CGRect rect = CGRectMake(50, 80, 350, 270); 
    CGPoint point;
    
    point = CGPointForAnchorPointInRect(VGCornerConvertToAnchorPoint(VGCornerTopLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80), @"point is not as expected");
    
    point = CGPointForAnchorPointInRect(VGCornerConvertToAnchorPoint(VGCornerTopRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80), @"point is not as expected");
    
    point = CGPointForAnchorPointInRect(VGCornerConvertToAnchorPoint(VGCornerBottomRight), rect);
    STAssertEquals(point, CGPointMake(50 + 350, 80 + 270), @"point is not as expected");
    
    point = CGPointForAnchorPointInRect(VGCornerConvertToAnchorPoint(VGCornerBottomLeft), rect);
    STAssertEquals(point, CGPointMake(50, 80 + 270), @"point is not as expected");
}

- (void)testCGPointDistanceBetweenPoints
{
    CGPoint p1, p2;
    p1 = CGPointMake(50, 40);
    p2 = CGPointMake(10, 70);
    
    STAssertEquals(CGPointDistanceBetweenPoints(p1, p2), 50.0f, @"Distance is not calculated correctly");
}

- (void)testCGPointNormalizedDistance
{
    CGPoint p1, p2;
    p1 = CGPointMake(50, 40);
    p2 = CGPointMake(10, 70);
    
    STAssertEquals(CGPointNormalizedDistance(p1, p2), CGPointMake(-40, 30), @"Distance is not calculated correctly");
}

- (void)testNormalVectorWhenXAxisIsRotated
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 201, 305)]; 
    
    // Rotating 180degrees around xaxis
    view.layer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0);
    AGVector3D normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];    
    AGVector3D expectedVector = AGVector3DMake(0.0, 0.0, -1.0);    
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
    
    // Rotating 90degrees around xaxis
    view.layer.transform = CATransform3DMakeRotation(M_PI_2, 1.0, 0.0, 0.0);
    normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];
    expectedVector = AGVector3DMake(0.0, -1.0, 0.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
    
    // Rotating -90degrees around xaxis
    view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 1.0, 0.0, 0.0);
    normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];
    expectedVector = AGVector3DMake(0.0, 1.0, 0.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
}

- (void)testNormalVectorWhenYAxisIsRotated
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 201, 305)];
    
    // Rotating 180degrees around yaxis
    view.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    AGVector3D normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];
    AGVector3D expectedVector = AGVector3DMake(0.0, 0.0, -1.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
    
    // Rotating 90degrees around yaxis
    view.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
    normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];
    expectedVector = AGVector3DMake(1.0, 0.0, 0.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
    
    // Rotating -90degrees around yaxis
    view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
    normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:0.0f];
    expectedVector = AGVector3DMake(-1.0, 0.0, 0.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
}


// Normal vector should be (0.0, 0.0, 1.0) with whatever zrotation
- (void)testNormalVectorWhenZAxisIsRotated
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 201, 305)];
    
    // Rotating 180degrees around yaxis
    AGVector3D normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:M_PI];
    AGVector3D expectedVector = AGVector3DMake(0.0, 0.0, 1.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
    
    // Rotating 180degrees around yaxis
    normalVector = [AGGeometryHelper normalVectorForView:view withZRotation:M_PI_2];
    expectedVector = AGVector3DMake(0.0, 0.0, 1.0);
    
    STAssertEqualsWithAccuracy(normalVector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", normalVector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(normalVector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", normalVector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(normalVector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", normalVector.z, expectedVector.z);
}

- (void)testShadowVectorForPointWithLightPoint
{
    AGPoint3D lightPoint = AGPoint3DMake(0.0, 0.0, 100.0);
    AGPoint3D point = AGPoint3DMake(0.0, 0.0, 20.0);
    CGPoint shadowVector = [AGGeometryHelper shadowVectorForPoint:point lightPoint:lightPoint];
    CGPoint expectedShadowVector = CGPointMake(0, 0);
    STAssertEquals(shadowVector, expectedShadowVector, @"Shadowvector is %@ but should be %@", NSStringFromCGPoint(shadowVector), NSStringFromCGPoint(expectedShadowVector));
    
    lightPoint = AGPoint3DMake(0.0, 0.0, 100.0);
    point = AGPoint3DMake(10.0, 10.0, 20.0);
    shadowVector = [AGGeometryHelper shadowVectorForPoint:point lightPoint:lightPoint];
    expectedShadowVector = CGPointMake(-2.5, -2.5);
    STAssertEquals(shadowVector, expectedShadowVector, @"Shadowvector is %@ but should be %@", NSStringFromCGPoint(shadowVector), NSStringFromCGPoint(expectedShadowVector));
    
    
}

- (void)testInterpolate
{

    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(70, 60, 200, 40);
        CGRect rectp00 = CGRectInterpolate(rect1, rect2, 0.0f);
        CGRect rectp03 = CGRectInterpolate(rect1, rect2, 0.3f);
        CGRect rectp05 = CGRectInterpolate(rect1, rect2, 0.5f);
        CGRect rectp07 = CGRectInterpolate(rect1, rect2, 0.7f);
        CGRect rectp1 = CGRectInterpolate(rect1, rect2, 1.0f);
        
        STAssertEquals(rectp00, CGRectMake(10.0f, 50.0f, 150.0f, 100.0f), @"Unecpexted");
        STAssertEquals(rectp03, CGRectMake(28.0f, 53.0f, 165.0f, 82.0f), @"Unecpexted");
        STAssertEquals(rectp05, CGRectMake(40.0f, 55.0f, 175.0f, 70.0f), @"Unecpexted");
        STAssertEquals(rectp07, CGRectMake(52.0f, 57.0f, 185.0f, 58.0f), @"Unecpexted");
        STAssertEquals(rectp1, CGRectMake(70.0f, 60.0f, 200.0f, 40.0f), @"Unecpexted");
    }
    
    {
        CGRect rect1 = CGRectMake(10, 50, 150, 100);
        CGRect rect2 = CGRectMake(-20, 60, 200, 40);
        CGRect rectp00 = CGRectInterpolate(rect1, rect2, 0.0f);
        CGRect rectp03 = CGRectInterpolate(rect1, rect2, 0.3f);
        CGRect rectp1 = CGRectInterpolate(rect1, rect2, 1.0f);
        
        STAssertEquals(rectp00, CGRectMake(10.0f, 50.0f, 150.0f, 100.0f), @"Unecpexted");
        STAssertEquals(rectp03, CGRectMake(1.0f, 53.0f, 165.0f, 82.0f), @"Unecpexted");
        STAssertEquals(rectp1, CGRectMake(-20.0f, 60.0f, 200.0f, 40.0f), @"Unecpexted");
    }

}

- (void)testInterPolateWithFunction
{
    CGRect rect1    = CGRectMake(0, 0, 200, 200);
    CGRect rect2    = CGRectMake(0, 0, 400, 400);
    CGRect expected = CGRectMake(0, 0, 396, 396);
    CGRect rectip  = CGRectInterpolateWithFunction(rect1, rect2, 0.9f, &QuadraticEaseInOut);
    STAssertEquals(rectip, expected, @"Unexpected");
    
    rect1    = CGRectMake(30, 70, 200, 200);
    rect2    = CGRectMake(100, 50, 600, 250);
    expected = CGRectMake(98.6, 50.4, 592, 249);
    rectip  = CGRectInterpolateWithFunction(rect1, rect2, 0.9f, &QuadraticEaseInOut);
    STAssertEquals(rectip, expected, @"Unexpected");

    rect1    = CGRectMake(30, 70, 200, 200);
    rect2    = CGRectMake(100, 50, 600, 250);
    expected = CGRectMake(77.6, 56.4, 472 , 234);
    rectip  = CGRectInterpolateWithFunction(rect1, rect2, 0.6f, &QuadraticEaseInOut);
    
    STAssertEqualsWithAccuracy(expected.origin.x, rectip.origin.x, 0.001, @"Unexpected");
    STAssertEqualsWithAccuracy(expected.origin.y, rectip.origin.y, 0.001, @"Unexpected");
    STAssertEqualsWithAccuracy(expected.size.height, rectip.size.height, 0.001, @"Unexpected");
    STAssertEqualsWithAccuracy(expected.size.width, rectip.size.width, 0.001, @"Unexpected");
}

- (void)testCGSizeGreatestSize
{
    {
        CGSize smallerSize = CGSizeMake(20, 51.232);
        CGSize biggerSize = CGSizeMake(20, 51.2366);
        CGSize result = CGSizeGreatestSize(biggerSize, smallerSize);
        STAssertEquals(result, biggerSize, @"What!?");
    }
    {
        CGSize smallerSize = CGSizeMake(20, 51.232);
        CGSize biggerSize = CGSizeMake(31, 51.2366);
        CGSize result = CGSizeGreatestSize(biggerSize, smallerSize);
        STAssertEquals(result, biggerSize, @"What!?");
    }
    {
        CGSize smallerSize = CGSizeMake(20, 51.232);
        CGSize biggerSize = CGSizeMake(15, 51.2366);
        CGSize result = CGSizeGreatestSize(biggerSize, smallerSize);
        STAssertEquals(result, smallerSize, @"If one size is smaller.. then size is smaller..");
    }
    {
        CGSize smallerSize = CGSizeMake(20, 51.232);
        CGSize biggerSize = CGSizeMake(10, 12);
        CGSize result = CGSizeGreatestSize(biggerSize, smallerSize);
        STAssertEquals(result, smallerSize, @"None of \"biggerSize\" params is greater...");
    }
    {
        // equal
        CGSize smallerSize = CGSizeMake(20, 51.232);
        CGSize biggerSize = smallerSize;
        CGSize result = CGSizeGreatestSize(biggerSize, smallerSize);
        STAssertEquals(result, smallerSize, @"If equal: it should return of the sides");
    }
}

@end
