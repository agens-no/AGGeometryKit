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

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GLKit/GLKVector3.h"

struct AGVector3D {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};
typedef struct AGVector3D AGVector3D;

const AGVector3D AGVector3DZero;

AGVector3D AGVector3DMake(CGFloat x, CGFloat y, CGFloat z);
AGVector3D AGVector3DWithGLKVector3(GLKVector3);
CGFloat AGVector3DGetLength(AGVector3D v);
AGVector3D AGVector3DAdd(AGVector3D v1, AGVector3D v2);
AGVector3D AGVector3DSubtract(AGVector3D v1, AGVector3D v2);
AGVector3D AGVector3DNegate(AGVector3D v);
AGVector3D AGVector3DNormalize(AGVector3D v);
CGFloat AGVector3DDotProduct(AGVector3D v1, AGVector3D v2);
AGVector3D AGVector3DCrossProduct(AGVector3D v1, AGVector3D v2);
AGVector3D AGVector3DGetTriangleNormal(AGVector3D v1, AGVector3D v2, AGVector3D v3);
AGVector3D AGVector3DPositionFromTransform(CATransform3D m);
AGVector3D AGVector3DApplyTransform(AGVector3D vector, CATransform3D m);
AGVector3D AGVector3DApplyTransformWithNoTranslate(AGVector3D vector, CATransform3D m);

