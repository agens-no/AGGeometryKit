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

#import "AGPoint3D.h"

AGPoint3D AGPoint3DMake(CGFloat x, CGFloat y, CGFloat z)
{
    AGPoint3D point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

AGPoint3D AGPoint3DMakeWithCGPoint(CGPoint CGPoint)
{
    return AGPoint3DMake(CGPoint.x, CGPoint.y, 0.0);
}

CGFloat AGPoint3DGetDistanceXYAxis(AGPoint3D p1, AGPoint3D p2)
{
    return sqrtf(powf(p2.x - p1.x, 2.0f) + powf(p2.y - p1.y, 2.0f));
}

CGPoint AGPoint3DGetCGPoint(AGPoint3D v)
{
    return CGPointMake(v.x, v.y);
}