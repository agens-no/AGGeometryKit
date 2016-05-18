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

#import <XCTest/XCTest.h>
#import <AGGeometryKit/AGKVector3D.h>

@interface AGKVector3DTest : XCTestCase

@end

@implementation AGKVector3DTest

- (void)testAGKVector3DGetTriangleNormal
{
    {
        AGKVector3D v1 = AGKVector3DMake(0, 0, 0);
        AGKVector3D v2 = AGKVector3DMake(1, 0, 0);
        AGKVector3D v3 = AGKVector3DMake(1, 1, 0);
        AGKVector3D vector =  AGKVector3DGetTriangleNormal(v1, v2, v3);
        AGKVector3D expectedVector = AGKVector3DMake(0, 0, 1);

        XCTAssertEqualWithAccuracy(vector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", vector.x, expectedVector.x);
        XCTAssertEqualWithAccuracy(vector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", vector.y, expectedVector.y);
        XCTAssertEqualWithAccuracy(vector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", vector.z, expectedVector.z);
    }
    {
        AGKVector3D v1 = AGKVector3DMake(0, 0, 0);
        AGKVector3D v2 = AGKVector3DMake(1, 0, 0);
        AGKVector3D v3 = AGKVector3DMake(1, 0, 1);
        AGKVector3D vector =  AGKVector3DGetTriangleNormal(v1, v2, v3);
        AGKVector3D expectedVector = AGKVector3DMake(0, -1, 0);

        XCTAssertEqualWithAccuracy(vector.x, expectedVector.x, 0.001, @"Normal vector x is %f but was expected %f", vector.x, expectedVector.x);
        XCTAssertEqualWithAccuracy(vector.y, expectedVector.y, 0.001, @"Normal vector y is %f but was expected %f", vector.y, expectedVector.y);
        XCTAssertEqualWithAccuracy(vector.z, expectedVector.z, 0.001, @"Normal vector z is %f but was expected %f", vector.z, expectedVector.z);
    }
}

@end
