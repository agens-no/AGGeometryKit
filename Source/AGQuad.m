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

#import "AGQuad.h"
#import "AGMath.h"
#import "AGLine.h"
#import "CGGeometry+AGGeometryKit.h"

/*
 
 
 REFERENCES FOR FURTHER STUDYING
 http://pastebin.com/90De4QqT
 http://stackoverflow.com/questions/9470493/transforming-a-rectangle-image-into-a-quadrilateral-using-a-catransform3d
 http://stackoverflow.com/questions/9088882/return-catransform3d-to-map-quadrilateral-to-quadrilateral
 
 
 */



const AGQuad AGQuadZero = { (AGPoint){0, 0}, (AGPoint){0, 0}, (AGPoint){0, 0}, (AGPoint){0, 0} };

extern BOOL AGQuadEqual(AGQuad q1, AGQuad q2)
{
    for(int i = 0; i < 4; i++)
    {
        if(!AGPointEqual(q1.v[i], q2.v[i]))
        {
            return NO;
        }
    }
    return YES;
}

extern BOOL AGQuadIsConvex(AGQuad q)
{
    BOOL isConvex = AGLineIntersection(AGLineMake(q.bl, q.tr), AGLineMake(q.br, q.tl), NULL);
    return isConvex;
}

extern BOOL AGQuadIsValid(AGQuad q)
{
    return AGQuadIsConvex(q);
}

extern AGQuad AGQuadMove(AGQuad q, CGFloat x, CGFloat y)
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

extern AGQuad AGQuadInsetLeft(AGQuad q, CGFloat inset)
{
    q.tl.x += inset;
    q.bl.x += inset;
    return q;
}

extern AGQuad AGQuadInsetRight(AGQuad q, CGFloat inset)
{
    q.tr.x -= inset;
    q.br.x -= inset;
    return q;
}

extern AGQuad AGQuadInsetTop(AGQuad q, CGFloat inset)
{
    q.tl.y += inset;
    q.tr.y += inset;
    return q;
}

extern AGQuad AGQuadInsetBottom(AGQuad q, CGFloat inset)
{
    q.tl.y -= inset;
    q.tr.y -= inset;
    return q;
}

extern AGQuad AGQuadMirror(AGQuad q, BOOL x, BOOL y)
{
    AGQuad mirroredQ;
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

extern AGQuad AGQuadMake(AGPoint tl, AGPoint tr, AGPoint br, AGPoint bl)
{
    return (AGQuad){.tl = tl, .tr = tr, .br = br, .bl = bl};
}

extern AGQuad AGQuadMakeWithCGPoints(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl)
{
    AGQuad q;
    q.tl = AGPointMakeWithCGPoint(tl);
    q.tr = AGPointMakeWithCGPoint(tr);
    q.br = AGPointMakeWithCGPoint(br);
    q.bl = AGPointMakeWithCGPoint(bl);
    return q;
}

extern AGQuad AGQuadMakeWithCGRect(CGRect rect)
{
    AGQuad q;
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

extern AGQuad AGQuadMakeWithCGSize(CGSize size)
{
    AGQuad q = AGQuadZero;
    q.tr.x = size.width;
    q.br.x = size.width;
    q.bl.y = size.height;
    q.br.y = size.height;
    return q;
}

extern CGFloat AGQuadGetSmallestX(AGQuad q)
{
    CGFloat values[4];
    AGQuadGetXValues(q, values);
    return agMinInArray(values, 4, NULL);
}

extern CGFloat AGQuadGetBiggestX(AGQuad q)
{
    CGFloat values[4];
    AGQuadGetXValues(q, values);
    return agMaxInArray(values, 4, NULL);
}

extern CGFloat AGQuadGetSmallestY(AGQuad q)
{
    CGFloat values[4];
    AGQuadGetYValues(q, values);
    return agMinInArray(values, 4, NULL);
}

extern CGFloat AGQuadGetBiggestY(AGQuad q)
{
    CGFloat values[4];
    AGQuadGetYValues(q, values);
    return agMaxInArray(values, 4, NULL);
}

extern CGRect AGQuadGetBoundingRect(AGQuad q)
{
    CGFloat xValues[4];
    CGFloat yValues[4];
    AGQuadGetXValues(q, xValues);
    AGQuadGetYValues(q, yValues);
    
    CGFloat xmin = agMinInArray(xValues, 4, NULL);
    CGFloat xmax = agMaxInArray(xValues, 4, NULL);
    CGFloat ymin = agMinInArray(yValues, 4, NULL);
    CGFloat ymax = agMaxInArray(yValues, 4, NULL);
    
    CGRect rect;
    rect.origin.x = xmin;
    rect.origin.y = ymin;
    rect.size.width = xmax - xmin;
    rect.size.height = ymax - ymin;
    
    return rect;
}

extern AGPoint AGQuadGetCenter(AGQuad q)
{
    AGPoint center = AGPointZero;
    AGLineIntersection(AGLineMake(q.bl, q.tr), AGLineMake(q.br, q.tl), &center);
    return center;
}

extern CGSize AGQuadGetSize(AGQuad q)
{
    CGRect smallestRect = AGQuadGetBoundingRect(q);
    return smallestRect.size;
}

void AGQuadGetXValues(AGQuad q, CGFloat *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = q.v[i];
        out_values[i] = p.x;
    }
}

void AGQuadGetYValues(AGQuad q, CGFloat *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = q.v[i];
        out_values[i] = p.y;
    }
}

extern AGQuad AGQuadInterpolation(AGQuad q1, AGQuad q2, CGFloat progress)
{
    AGQuad q;
    for(int i = 0; i < 4; i++)
    {
        q.v[i] = AGPointInterpolate(q1.v[i], q2.v[i], progress);
    }
    return q;
}

extern AGQuad AGQuadApplyCGAffineTransform(AGQuad q, CGAffineTransform t)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint ap1 = q.v[i];
        CGPoint cp1 = AGPointAsCGPoint(ap1);
        CGPoint cp2 = CGPointApplyAffineTransform(cp1, t);
        AGPoint ap2 = AGPointMakeWithCGPoint(cp2);
        q.v[i] = ap2;
    }
    return q;
}

extern AGQuad AGQuadApplyCATransform3D(AGQuad q, CATransform3D t)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint ap1 = q.v[i];
        CGPoint cp1 = AGPointAsCGPoint(ap1);
        CGPoint cp2 = AGCGPointApplyCATransform3D(cp1, t, CGPointZero, CATransform3DIdentity);
        AGPoint ap2 = AGPointMakeWithCGPoint(cp2);
        q.v[i] = ap2;
    }
    return q;
}

extern NSString * NSStringFromAGQuad(AGQuad q)
{
    return [NSString stringWithFormat:@"tl: %@,\n\t"
            "tr: %@,\n\t"
            "br: %@,\n\t"
            "bl: %@",
            NSStringFromAGPoint(q.tl),
            NSStringFromAGPoint(q.tr),
            NSStringFromAGPoint(q.br),
            NSStringFromAGPoint(q.bl)
            ];
}

// This have slightly less operations than CATransform3DWithQuadFromRect since origin values at rect is omitted.
// We could of course use CGSize instead, but I don't know...
// Taken from https://github.com/Ciechan/BCGenieEffect/blob/master/UIView%2BGenie.m
// Which derives from http://stackoverflow.com/a/12820877/558816

CATransform3D CATransform3DWithQuadFromBounds(AGQuad q, CGRect rect)
{
    double W = rect.size.width;
    double H = rect.size.height;
    
    double x1a = q.tl.x;
    double y1a = q.tl.y;
    
    double x2a = q.tr.x;
    double y2a = q.tr.y;
    
    double x3a = q.bl.x;
    double y3a = q.bl.y;
    
    double x4a = q.br.x;
    double y4a = q.br.y;
    
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

CATransform3D CATransform3DWithQuadFromRect(AGQuad q, CGRect rect)
{
    double X = rect.origin.x;
    double Y = rect.origin.y;
    double W = rect.size.width;
    double H = rect.size.height;
    
    double x1a = q.tl.x;
    double y1a = q.tl.y;
    
    double x2a = q.tr.x;
    double y2a = q.tr.y;
    
    double x3a = q.bl.x;
    double y3a = q.bl.y;
    
    double x4a = q.br.x;
    double y4a = q.br.y;
    
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
