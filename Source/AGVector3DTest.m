//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <SenTestingKit/SenTestingKit.h>
#import "AGVector3D.h"

@interface AGVector3DTest : SenTestCase

@end

@implementation AGVector3DTest


- (void)testAGPoint3DGetDistanceXYAxis
{
    AGPoint3D p1 = AGPoint3DMake(0, 0, 0);
    AGPoint3D p2 = AGPoint3DMake(10, 0, 0);
    CGFloat distance =  AGPoint3DGetDistanceXYAxis(p1, p2);
    CGFloat expectedDistance = 10.0;
    
    STAssertEquals(distance, expectedDistance, @"Distance is %.2f but was expected %.2f", distance, expectedDistance);
    
    p1 = AGPoint3DMake(0, 0, 0);
    p2 = AGPoint3DMake(10, 10, 0);
    distance =  AGPoint3DGetDistanceXYAxis(p1, p2);
    expectedDistance = sqrtf(200.0);
    
    STAssertEquals(distance, expectedDistance, @"Distance is %.2f but was expected %.2f", distance, expectedDistance);
    
    p1 = AGPoint3DMake(0, 0, 0);
    p2 = AGPoint3DMake(10, 10, 10);
    distance =  AGPoint3DGetDistanceXYAxis(p1, p2);
    expectedDistance = sqrtf(200.0);
    
    STAssertEquals(distance, expectedDistance, @"Distance is %.2f but was expected %.2f", distance, expectedDistance);
}

- (void)testAGVector3DGetTriangleNormalFromPoints
{
    AGPoint3D p1 = AGPoint3DMake(0, 0, 0);
    AGPoint3D p2 = AGPoint3DMake(1, 0, 0);
    AGPoint3D p3 = AGPoint3DMake(1, 1, 0);
    AGVector3D vector =  AGVector3DGetTriangleNormalFromPoints(p1, p2, p3);
    AGVector3D expectedVector = AGVector3DMake(0, 0, 1);
    
    STAssertEqualsWithAccuracy(vector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", vector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(vector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", vector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(vector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", vector.z, expectedVector.z);
    
    p1 = AGPoint3DMake(0, 0, 0);
    p2 = AGPoint3DMake(1, 0, 0);
    p3 = AGPoint3DMake(1, 0, 1);
    vector =  AGVector3DGetTriangleNormalFromPoints(p1, p2, p3);
    expectedVector = AGVector3DMake(0, -1, 0);
    
    STAssertEqualsWithAccuracy(vector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", vector.x, expectedVector.x);
    STAssertEqualsWithAccuracy(vector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", vector.y, expectedVector.y);
    STAssertEqualsWithAccuracy(vector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", vector.z, expectedVector.z);

}
@end
