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

// Using AGPoint for
// - better precision with double when calculating transform for quadrilaterals
// - being able to access values with index

typedef union AGPoint {
    struct { double x, y; };
    double v[2];
} AGPoint;

extern const AGPoint AGPointZero;
inline BOOL AGPointEqual(AGPoint p1, AGPoint p2);
inline BOOL AGPointEqualToCGPoint(AGPoint p1, CGPoint p2);
inline AGPoint AGPointMakeWithCGPoint(CGPoint cg);
inline AGPoint AGPointMakeWithCGPointZeroFill(CGPoint cg);
inline AGPoint AGPointMake(double x, double y);
inline AGPoint AGPointInterpolate(AGPoint p1, AGPoint p2, double progress);
inline AGPoint AGPointSubtract(AGPoint p1, AGPoint p2);
inline AGPoint AGPointAdd(AGPoint p1, AGPoint p2);
inline AGPoint AGPointMultiply(AGPoint p1, double factor);
inline double AGPointDotProduct(AGPoint p1, AGPoint p2);
inline double AGPointCrossProduct(AGPoint p1, AGPoint p2);
inline CGPoint AGPointAsCGPoint(AGPoint p);
inline NSString * NSStringFromAGPoint(AGPoint p);
