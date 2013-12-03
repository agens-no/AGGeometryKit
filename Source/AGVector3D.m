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

#import "AGVector3D.h"
#import <QuartzCore/QuartzCore.h>

AGVector3D AGVector3DMake(CGFloat x, CGFloat y, CGFloat z)
{
    AGVector3D vector;
    vector.x = x;
    vector.y = y;
    vector.z = z;
    return vector;
}

AGVector3D AGVector3DMakeFromPoints(AGPoint3D p1, AGPoint3D p2)
{
    return AGVector3DMake(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);
}

CGFloat AGVector3DGetLength(AGVector3D v)
{
    return sqrtf(v.x * v.x + v.y * v.y + v.z * v.z);
}

AGVector3D AGVector3DAdd(AGVector3D v1, AGVector3D v2)
{
    return AGVector3DMake(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

AGVector3D AGVector3DSubtract(AGVector3D v1, AGVector3D v2)
{
    return AGVector3DMake(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
}

AGVector3D AGVector3DNegate(AGVector3D v)
{
    return AGVector3DMake(-v.x, -v.y, -v.z);
}

AGVector3D AGVector3DNormalize(AGVector3D v)
{
    CGFloat length = AGVector3DGetLength(v);
    if(length != 0.0)
    {
        v.x /= length;
        v.y /= length;
        v.z /= length;
    }
    return v;
}

CGFloat AGVector3DDotProduct(AGVector3D v1, AGVector3D v2)
{
    return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z);
}

AGVector3D AGVector3DCrossProduct(AGVector3D v1, AGVector3D v2)
{
    return AGVector3DMake(v1.y * v2.z - v1.z * v2.y,
                          v1.z * v2.x - v1.x * v2.z,
                          v1.x * v2.y - v1.y * v2.x);
}

AGVector3D AGVector3DMakeWithAGPoint3D(AGPoint3D point)
{
    return AGVector3DMake(point.x, point.y, point.z);
}

AGVector3D AGVector3DForGLKVector3(GLKVector3 vec)
{
#if defined(__STRICT_ANSI__)
    return AGVector3DMake(vec.v[0], vec.v[1], vec.v[2]);
#else
    return AGVector3DMake(vec.x, vec.y, vec.z);
#endif
}

AGVector3D AGVector3DGetTriangleNormalFromPoints(AGPoint3D p1, AGPoint3D p2, AGPoint3D p3)
{
    AGVector3D v1 = AGVector3DMakeWithAGPoint3D(p1);
    AGVector3D v2 = AGVector3DMakeWithAGPoint3D(p2);
    AGVector3D v3 = AGVector3DMakeWithAGPoint3D(p3);
    return AGVector3DGetTriangleNormal(v1, v2, v3);
}

AGVector3D AGVector3DGetTriangleNormal(AGVector3D v1, AGVector3D v2, AGVector3D v3)
{
    AGVector3D edge1 = AGVector3DSubtract(v1, v2);
    AGVector3D edge2 = AGVector3DSubtract(v1, v3);
    AGVector3D surfaceNormal = AGVector3DCrossProduct(edge1, edge2);    
    return surfaceNormal;
}