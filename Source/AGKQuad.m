//
// Author: Håvard Fossli <hfossli@agens.no>
// Author: https://github.com/kennytm
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

#import "AGKQuad.h"
#import "AGKMath.h"
#import "AGKLine.h"
#import "CGGeometry+AGGeometryKit.h"

/*
 
 
 REFERENCES FOR FURTHER STUDYING
 http://pastebin.com/90De4QqT
 http://stackoverflow.com/questions/9470493/transforming-a-rectangle-image-into-a-quadrilateral-using-a-catransform3d
 http://stackoverflow.com/questions/9088882/return-catransform3d-to-map-quadrilateral-to-quadrilateral
 
 
 */



const AGKQuad AGKQuadZero = { (CGPoint){0, 0}, (CGPoint){0, 0}, (CGPoint){0, 0}, (CGPoint){0, 0} };

extern BOOL AGKQuadEqual(AGKQuad q1, AGKQuad q2)
{
    for(int i = 0; i < 4; i++)
    {
        if(!CGPointEqualToPoint(q1.v[i], q2.v[i]))
        {
            return NO;
        }
    }
    return YES;
}

extern BOOL AGKQuadIsConvex(AGKQuad q)
{
    BOOL isConvex = AGKLineIntersection(AGKLineMake(q.bl, q.tr), AGKLineMake(q.br, q.tl), NULL);
    return isConvex;
}

extern BOOL AGKQuadIsValid(AGKQuad q)
{
    return AGKQuadIsConvex(q);
}

extern AGKQuad AGKQuadMove(AGKQuad q, CGFloat x, CGFloat y)
{
    q.tl.x += x;
    q.tr.x += x;
    q.bl.x += x;
    q.br.x += x;
    q.tl.y += y;
    q.tr.y += y;
    q.bl.y += y;
    q.br.y += y;
    return q;
}

extern AGKQuad AGKQuadInsetLeft(AGKQuad q, CGFloat inset)
{
    q.tl.x += inset;
    q.bl.x += inset;
    return q;
}

extern AGKQuad AGKQuadInsetRight(AGKQuad q, CGFloat inset)
{
    q.tr.x -= inset;
    q.br.x -= inset;
    return q;
}

extern AGKQuad AGKQuadInsetTop(AGKQuad q, CGFloat inset)
{
    q.tl.y += inset;
    q.tr.y += inset;
    return q;
}

extern AGKQuad AGKQuadInsetBottom(AGKQuad q, CGFloat inset)
{
    q.tl.y -= inset;
    q.tr.y -= inset;
    return q;
}

extern AGKQuad AGKQuadMirror(AGKQuad q, BOOL x, BOOL y)
{
    AGKQuad mirroredQ;
    if(x)
    {
        mirroredQ.tl.x = q.tr.x;
        mirroredQ.tr.x = q.tl.x;
        mirroredQ.bl.x = q.br.x;
        mirroredQ.br.x = q.bl.x;
    }
    if(y)
    {
        mirroredQ.tl.y = q.tr.y;
        mirroredQ.tr.y = q.tl.y;
        mirroredQ.bl.y = q.br.y;
        mirroredQ.br.y = q.bl.y;
    }
    return mirroredQ;
}

extern AGKQuad AGKQuadMake(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl)
{
    return (AGKQuad){.tl = tl, .tr = tr, .br = br, .bl = bl};
}

extern AGKQuad AGKQuadMakeWithCGRect(CGRect rect)
{
    AGKQuad q;
    q.tl.x = CGRectGetMinX(rect);
    q.tl.y = CGRectGetMinY(rect);
    q.tr.x = CGRectGetMaxX(rect);
    q.tr.y = CGRectGetMinY(rect);
    q.br.x = CGRectGetMaxX(rect);
    q.br.y = CGRectGetMaxY(rect);
    q.bl.x = CGRectGetMinX(rect);
    q.bl.y = CGRectGetMaxY(rect);
    return q;
}

extern AGKQuad AGKQuadMakeWithCGSize(CGSize size)
{
    AGKQuad q = AGKQuadZero;
    q.tr.x = size.width;
    q.br.x = size.width;
    q.bl.y = size.height;
    q.br.y = size.height;
    return q;
}

extern CGFloat AGKQuadGetSmallestX(AGKQuad q)
{
    CGFloat values[4];
    AGKQuadGetXValues(q, values);
    return AGKMinInArray(values, 4, NULL);
}

extern CGFloat AGKQuadGetBiggestX(AGKQuad q)
{
    CGFloat values[4];
    AGKQuadGetXValues(q, values);
    return AGKMaxInArray(values, 4, NULL);
}

extern CGFloat AGKQuadGetSmallestY(AGKQuad q)
{
    CGFloat values[4];
    AGKQuadGetYValues(q, values);
    return AGKMinInArray(values, 4, NULL);
}

extern CGFloat AGKQuadGetBiggestY(AGKQuad q)
{
    CGFloat values[4];
    AGKQuadGetYValues(q, values);
    return AGKMaxInArray(values, 4, NULL);
}

extern CGRect AGKQuadGetBoundingRect(AGKQuad q)
{
    CGFloat xValues[4];
    CGFloat yValues[4];
    AGKQuadGetXValues(q, xValues);
    AGKQuadGetYValues(q, yValues);
    
    CGFloat xmin = AGKMinInArray(xValues, 4, NULL);
    CGFloat xmax = AGKMaxInArray(xValues, 4, NULL);
    CGFloat ymin = AGKMinInArray(yValues, 4, NULL);
    CGFloat ymax = AGKMaxInArray(yValues, 4, NULL);
    
    CGRect rect;
    rect.origin.x = xmin;
    rect.origin.y = ymin;
    rect.size.width = xmax - xmin;
    rect.size.height = ymax - ymin;
    
    return rect;
}

extern CGPoint AGKQuadGetCenter(AGKQuad q)
{
    CGPoint center = CGPointZero;
    AGKLineIntersection(AGKLineMake(q.bl, q.tr), AGKLineMake(q.br, q.tl), &center);
    return center;
}

extern CGSize AGKQuadGetSize(AGKQuad q)
{
    CGRect smallestRect = AGKQuadGetBoundingRect(q);
    return smallestRect.size;
}

void AGKQuadGetXValues(AGKQuad q, CGFloat *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        CGPoint p = q.v[i];
        out_values[i] = p.x;
    }
}

void AGKQuadGetYValues(AGKQuad q, CGFloat *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        CGPoint p = q.v[i];
        out_values[i] = p.y;
    }
}

extern AGKQuad AGKQuadInterpolation(AGKQuad q1, AGKQuad q2, CGFloat progress)
{
    AGKQuad q;
    for(int i = 0; i < 4; i++)
    {
        q.v[i] = AGKCGPointInterpolate(q1.v[i], q2.v[i], progress);
    }
    return q;
}

extern AGKQuad AGKQuadApplyCGAffineTransform(AGKQuad q, CGAffineTransform t)
{
    for(int i = 0; i < 4; i++)
    {
        q.v[i] = CGPointApplyAffineTransform(q.v[i], t);
    }
    return q;
}

extern AGKQuad AGKQuadApplyCATransform3D(AGKQuad q, CATransform3D t)
{
    for(int i = 0; i < 4; i++)
    {
        q.v[i] = AGKCGPointApplyCATransform3D(q.v[i], t, CGPointZero, CATransform3DIdentity);
    }
    return q;
}

extern NSString * NSStringFromAGKQuad(AGKQuad q)
{
    return [NSString stringWithFormat:@"tl: %@,\n\t"
            "tr: %@,\n\t"
            "br: %@,\n\t"
            "bl: %@",
            NSStringFromCGPoint(q.tl),
            NSStringFromCGPoint(q.tr),
            NSStringFromCGPoint(q.br),
            NSStringFromCGPoint(q.bl)
            ];
}


// This have slightly less operations than CATransform3DWithQuadFromRect since origin values at rect is omitted.
// We could of course use CGSize instead, but I don't know...
// Taken from https://github.com/Ciechan/BCGenieEffect/blob/master/UIView%2BGenie.m
// Which derives from http://stackoverflow.com/a/12820877/558816

CATransform3D CATransform3DWithQuadFromBounds(AGKQuad q, CGRect rect)
{
    double W = floatToDoubleZeroFill(rect.size.width);
    double H = floatToDoubleZeroFill(rect.size.height);
    
    double x1a = floatToDoubleZeroFill(q.tl.x);
    double y1a = floatToDoubleZeroFill(q.tl.y);
    
    double x2a = floatToDoubleZeroFill(q.tr.x);
    double y2a = floatToDoubleZeroFill(q.tr.y);
    
    double x3a = floatToDoubleZeroFill(q.bl.x);
    double y3a = floatToDoubleZeroFill(q.bl.y);
    
    double x4a = floatToDoubleZeroFill(q.br.x);
    double y4a = floatToDoubleZeroFill(q.br.y);
    
    double y21 = y2a - y1a;
    double y32 = y3a - y2a;
    double y43 = y4a - y3a;
    double y14 = y1a - y4a;
    double y31 = y3a - y1a;
    double y42 = y4a - y2a;
    
    double a = -H*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42);
    double b = W*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    double c = - H*W*x1a*(x4a*y32 - x3a*y42 + x2a*y43);
    
    double d = H*(-x4a*y21*y3a + x2a*y1a*y43 - x1a*y2a*y43 - x3a*y1a*y4a + x3a*y2a*y4a);
    double e = W*(x4a*y2a*y31 - x3a*y1a*y42 - x2a*y31*y4a + x1a*y3a*y42);
    double f = -(W*(x4a*(H*y1a*y32) - x3a*(H)*y1a*y42 + H*x2a*y1a*y43));
    
    double g = H*(x3a*y21 - x4a*y21 + (-x1a + x2a)*y43);
    double h = W*(-x2a*y31 + x4a*y31 + (x1a - x3a)*y42);
    double i = H*(W*(-(x3a*y2a) + x4a*y2a + x2a*y3a - x4a*y3a - x2a*y4a + x3a*y4a));
    
    const double kEpsilon = 0.0001;
    
    if(fabs(i) < kEpsilon)
    {
        i = kEpsilon* (i > 0 ? 1.0 : -1.0);
    }
    
    CATransform3D transform = {a/i, d/i, 0, g/i, b/i, e/i, 0, h/i, 0, 0, 1, 0, c/i, f/i, 0, 1.0};
    
    return transform;
}

// Alterations should be updated to this post http://stackoverflow.com/a/12820877/558816
// The algorithm originates from this post http://stackoverflow.com/a/2352402/202451
//     by https://github.com/kennytm

CATransform3D CATransform3DWithQuadFromRect(AGKQuad q, CGRect rect)
{
    double X = floatToDoubleZeroFill(rect.origin.x);
    double Y = floatToDoubleZeroFill(rect.origin.y);
    double W = floatToDoubleZeroFill(rect.size.width);
    double H = floatToDoubleZeroFill(rect.size.height);

    double x1a = floatToDoubleZeroFill(q.tl.x);
    double y1a = floatToDoubleZeroFill(q.tl.y);

    double x2a = floatToDoubleZeroFill(q.tr.x);
    double y2a = floatToDoubleZeroFill(q.tr.y);

    double x3a = floatToDoubleZeroFill(q.bl.x);
    double y3a = floatToDoubleZeroFill(q.bl.y);

    double x4a = floatToDoubleZeroFill(q.br.x);
    double y4a = floatToDoubleZeroFill(q.br.y);
    
    double y21 = y2a - y1a;
    double y32 = y3a - y2a;
    double y43 = y4a - y3a;
    double y14 = y1a - y4a;
    double y31 = y3a - y1a;
    double y42 = y4a - y2a;
    
    double a = -H*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42);
    double b = W*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    double c = H*X*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42) - H*W*x1a*(x4a*y32 - x3a*y42 + x2a*y43) - W*Y*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    
    double d = H*(-x4a*y21*y3a + x2a*y1a*y43 - x1a*y2a*y43 - x3a*y1a*y4a + x3a*y2a*y4a);
    double e = W*(x4a*y2a*y31 - x3a*y1a*y42 - x2a*y31*y4a + x1a*y3a*y42);
    double f = -(W*(x4a*(Y*y2a*y31 + H*y1a*y32) - x3a*(H + Y)*y1a*y42 + H*x2a*y1a*y43 + x2a*Y*(y1a - y3a)*y4a + x1a*Y*y3a*(-y2a + y4a)) - H*X*(x4a*y21*y3a - x2a*y1a*y43 + x3a*(y1a - y2a)*y4a + x1a*y2a*(-y3a + y4a)));
    
    double g = H*(x3a*y21 - x4a*y21 + (-x1a + x2a)*y43);
    double h = W*(-x2a*y31 + x4a*y31 + (x1a - x3a)*y42);
    double i = W*Y*(x2a*y31 - x4a*y31 - x1a*y42 + x3a*y42) + H*(X*(-(x3a*y21) + x4a*y21 + x1a*y43 - x2a*y43) + W*(-(x3a*y2a) + x4a*y2a + x2a*y3a - x4a*y3a - x2a*y4a + x3a*y4a));
    
    const double kEpsilon = 0.0001;
    
    if(fabs(i) < kEpsilon)
    {
        i = kEpsilon* (i > 0 ? 1.0 : -1.0);
    }
    
    CATransform3D transform = {a/i, d/i, 0, g/i, b/i, e/i, 0, h/i, 0, 0, 1, 0, c/i, f/i, 0, 1.0};
    
    return transform;
}
