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

#import "AGKLine.h"
#import "CGGeometry+AGGeometryKit.h"

const AGKLine AGKLineZero = (AGKLine){(CGPoint){0.0, 0.0}, (CGPoint){0.0, 0.0}};

extern AGKLine AGKLineMake(CGPoint start, CGPoint end)
{
    return (AGKLine){start, end};
}

extern double AGKLineLength(AGKLine l)
{
    return sqrt(pow(l.start.x - l.end.x, 2.0f) + pow(l.start.y - l.end.y, 2.0f));
}

BOOL AGKLineIntersection(AGKLine l1, AGKLine l2, CGPoint *out_pointOfIntersection)
{
    // http://stackoverflow.com/a/565282/202451

    CGPoint p = l1.start;
    CGPoint q = l2.start;
    CGPoint r = AGKCGPointSubtract(l1.end, l1.start);
    CGPoint s = AGKCGPointSubtract(l2.end, l2.start);
    
    double s_r_crossProduct = AGKCGPointCrossProductZComponent(r, s);
    double t = AGKCGPointCrossProductZComponent(AGKCGPointSubtract(q, p), s) / s_r_crossProduct;
    double u = AGKCGPointCrossProductZComponent(AGKCGPointSubtract(q, p), r) / s_r_crossProduct;
    
    if(t < 0 || t > 1.0 || u < 0 || u > 1.0)
    {
        if(out_pointOfIntersection != NULL)
        {
            *out_pointOfIntersection = CGPointZero;
        }
        return NO;
    }
    else
    {
        if(out_pointOfIntersection != NULL)
        {
            CGPoint i = AGKCGPointAdd(p, AGKCGPointMultiply(r, t));
            *out_pointOfIntersection = i;
        }
        return YES;
    }
}