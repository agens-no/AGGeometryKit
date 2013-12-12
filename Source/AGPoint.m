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

#import "AGPoint.h"
#import "AGMath.h"

const AGPoint AGPointZero = (AGPoint){0, 0};

extern BOOL AGPointEqual(AGPoint p1, AGPoint p2)
{
    return p1.x == p2.x && p1.x == p2.x;
}

extern BOOL AGPointEqualToCGPoint(AGPoint p1, CGPoint p2)
{
    return ((CGFloat)p1.x) == p2.x && ((CGFloat)p1.x) == p2.x;
}

extern AGPoint AGPointMakeWithCGPoint(CGPoint cg)
{
    AGPoint ag = {cg.x, cg.y};
    return ag;
}

extern AGPoint AGPointMake(double x, double y)
{
    return (AGPoint){x, y};
}

extern AGPoint AGPointInterpolate(AGPoint p1, AGPoint p2, double progress)
{
    AGPoint result;
    result.x = agInterpolate(p1.x, p2.x, progress);
    result.y = agInterpolate(p1.y, p2.y, progress);
    return result;
}

extern AGPoint AGPointSubtract(AGPoint p1, AGPoint p2)
{
    return (AGPoint){p1.x - p2.x, p1.y - p2.y};
}

extern AGPoint AGPointAdd(AGPoint p1, AGPoint p2)
{
    return (AGPoint){p1.x + p2.x, p1.y + p2.y};
}

extern AGPoint AGPointMultiply(AGPoint p1, double factor)
{
    return (AGPoint){p1.x * factor, p1.y * factor};
}

extern double AGPointDotProduct(AGPoint p1, AGPoint p2)
{
    return (p1.x * p2.x) + (p1.y * p2.y);
}

extern double AGPointCrossProduct(AGPoint p1, AGPoint p2)
{
    return (p1.x * p2.y) - (p1.y * p2.x);
}

extern CGPoint AGPointAsCGPoint(AGPoint p)
{
    return CGPointMake(p.x, p.y);
}

extern NSString * NSStringFromAGPoint(AGPoint p)
{
    return [NSString stringWithFormat:@"{%f, %f}", p.x, p.y];
}

