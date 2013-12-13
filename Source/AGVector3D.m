//
// Authors:
// Håvard Fossli <hfossli@agens.no>
// Marcus Eckert <marcuseckert@gmail.com>
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

AGVector3D AGVector3DForGLKVector3(GLKVector3 vec)
{
#if defined(__STRICT_ANSI__)
    return AGVector3DMake(vec.v[0], vec.v[1], vec.v[2]);
#else
    return AGVector3DMake(vec.x, vec.y, vec.z);
#endif
}

AGVector3D AGVector3DGetTriangleNormal(AGVector3D v1, AGVector3D v2, AGVector3D v3)
{
    AGVector3D edge1 = AGVector3DSubtract(v1, v2);
    AGVector3D edge2 = AGVector3DSubtract(v1, v3);
    AGVector3D surfaceNormal = AGVector3DCrossProduct(edge1, edge2);    
    return surfaceNormal;
}

AGVector3D AGVector3DPositionFromTransform(CATransform3D m)
{
    return AGVector3DMake(m.m41, m.m42, m.m43);
}

AGVector3D AGVector3DApplyTransform(AGVector3D vector, CATransform3D m)
{
    AGVector3D p;

    p.x = (m.m11 * vector.x + m.m21 * vector.y + m.m31 * vector.z + m.m41);
    p.y = (m.m12 * vector.x + m.m22 * vector.y + m.m32 * vector.z + m.m42);
    p.z = (m.m13 * vector.x + m.m23 * vector.y + m.m33 * vector.z + m.m43);

    return p;
}

AGVector3D AGVector3DApplyTransformWithNoTranslate(AGVector3D vector, CATransform3D m)
{
    AGVector3D p;

    p.x = (m.m11 * vector.x + m.m21 * vector.y + m.m31 * vector.z);
    p.y = (m.m12 * vector.x + m.m22 * vector.y + m.m32 * vector.z);
    p.z = (m.m13 * vector.x + m.m23 * vector.y + m.m33 * vector.z);

    return p;
}
