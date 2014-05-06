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

#import <Foundation/Foundation.h>

/*
 tl = top left
 tr = top right
 br = bottom right
 bl = bottom left
 */

typedef union AGKQuad {
    struct { CGPoint tl, tr, br, bl; };
    CGPoint v[4];
} AGKQuad;

extern const AGKQuad AGKQuadZero;
inline BOOL AGKQuadEqual(AGKQuad q1, AGKQuad q2);
inline BOOL AGKQuadIsConvex(AGKQuad q);
inline BOOL AGKQuadIsValid(AGKQuad q);
inline AGKQuad AGKQuadMove(AGKQuad q, CGFloat x, CGFloat y);
inline AGKQuad AGKQuadInsetLeft(AGKQuad q, CGFloat inset);
inline AGKQuad AGKQuadInsetRight(AGKQuad q, CGFloat inset);
inline AGKQuad AGKQuadInsetTop(AGKQuad q, CGFloat inset);
inline AGKQuad AGKQuadInsetBottom(AGKQuad q, CGFloat inset);
inline AGKQuad AGKQuadMirror(AGKQuad q, BOOL x, BOOL y);
inline AGKQuad AGKQuadMake(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl);
inline AGKQuad AGKQuadMakeWithCGRect(CGRect rect);
inline AGKQuad AGKQuadMakeWithCGSize(CGSize size);
inline CGFloat AGKQuadGetSmallestX(AGKQuad q);
inline CGFloat AGKQuadGetBiggestX(AGKQuad q);
inline CGFloat AGKQuadGetSmallestY(AGKQuad q);
inline CGFloat AGKQuadGetBiggestY(AGKQuad q);
inline CGRect AGKQuadGetBoundingRect(AGKQuad q);
inline CGPoint AGKQuadGetCenter(AGKQuad q);
inline CGSize AGKQuadGetSize(AGKQuad q);
void AGKQuadGetXValues(AGKQuad q, CGFloat *out_values);
void AGKQuadGetYValues(AGKQuad q, CGFloat *out_values);
inline AGKQuad AGKQuadInterpolation(AGKQuad q1, AGKQuad q2, CGFloat progress);
inline AGKQuad AGKQuadApplyCGAffineTransform(AGKQuad q, CGAffineTransform t);
inline AGKQuad AGKQuadApplyCATransform3D(AGKQuad q, CATransform3D t);
inline NSString * NSStringFromAGKQuad(AGKQuad q);

/**
 * @discussion
 *   It is only possible to make 'convex quadrilateral' with transforms.
 *   So make sure your quadrilateral is convex.
 *   http://upload.wikimedia.org/wikipedia/commons/f/f1/Quadrilateral_hierarchy.png
 */
CATransform3D CATransform3DWithQuadFromBounds(AGKQuad q, CGRect rect);
CATransform3D CATransform3DWithQuadFromRect(AGKQuad q, CGRect rect);

