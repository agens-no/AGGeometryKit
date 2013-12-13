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

#import <Foundation/Foundation.h>

// http://processingjs.nihongoresources.com/bezierinfo/




CGPoint CGPointGetPointForAnchorPointInRect(CGPoint anchor, CGRect rect);
CGPoint CGPointGetAnchorPointForPointInRect(CGPoint point, CGRect rect);
CGPoint CGPointForCenterInRect(CGRect rect);
inline CGFloat CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2);
inline double CGSizeGetAspectRatio(CGSize size);
inline BOOL CGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2);
CGSize CGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner);
inline BOOL CGRectGotAnyNanValues(CGRect rect);
inline BOOL CGSizeGotAnyNanValues(CGSize size);
inline BOOL CGPointGotAnyNanValues(CGPoint origin);
inline CGPoint CGPointAddSize(CGPoint p, CGSize s);
inline CGRect CGRectMakeWithSize(CGSize size);
inline CGPoint CGRectGetMidPoint(CGRect rect);
inline CGSize CGSizeGetHalf(CGSize size);
inline CGSize CGSizeSwitchAxis(CGSize size);
inline CGRect CGRectWithSize(CGRect rect, CGSize newSize);
inline CGRect CGRectWithWidth(CGRect rect, CGFloat newWidth);
inline CGRect CGRectWithHeight(CGRect rect, CGFloat newHeight);
inline CGRect CGRectWithOrigin(CGRect rect, CGPoint origin);
inline CGRect CGRectWithOriginMinX(CGRect rect, CGFloat value);
inline CGRect CGRectWithOriginMinY(CGRect rect, CGFloat value);
inline CGRect CGRectWithOriginMaxY(CGRect rect, CGFloat value);
inline CGRect CGRectWithOriginMaxX(CGRect rect, CGFloat value);
inline CGRect CGRectWithOriginMidX(CGRect rect, CGFloat value);
inline CGRect CGRectWithOriginMidY(CGRect rect, CGFloat value);
inline CGRect CGRectApply(CGRect rect, CGRect (^block)(CGRect rect));
inline CGSize CGSizeApply(CGSize size, CGSize (^block)(CGSize size));
inline CGPoint CGPointApply(CGPoint point, CGPoint (^block)(CGPoint point));
CGRect CGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints);
CGSize CGSizeDistanceBetweenRects(CGRect rect1, CGRect rect2);
CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress);
CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress);
CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress);
CGPoint CGPointApplyCATransform3D(CGPoint point,
                                  CATransform3D transform,
                                  CGPoint anchorPoint,
                                  CATransform3D parentSublayerTransform);
inline CGPoint CGPointVectorNormalize(CGPoint v);
inline CGFloat CGPointVectorGetLength(CGPoint v);
inline CGFloat CGPointVectorDotProduct(CGPoint v1, CGPoint v2);
inline CGFloat CGPointVectorCrossProductZComponent(CGPoint v1, CGPoint v2);
inline CGFloat CGSizeScalarToAspectFit(CGSize sizeToFit, CGSize container);
inline CGFloat CGSizeScalarToAspectFill(CGSize sizeToFill, CGSize container);
inline CGPoint CGPointSubtract(CGPoint p1, CGPoint p2);
inline CGPoint CGPointAdd(CGPoint p1, CGPoint p2);
inline CGPoint CGPointMultiply(CGPoint p1, CGFloat factor);
inline CGPoint CGPointDivide(CGPoint p1, CGFloat factor);
inline CGFloat CGPointDotProduct(CGPoint p1, CGPoint p2);
inline CGPoint CGPointRotate(CGPoint point, CGFloat angle);
inline CGPoint CGPointRotateAroundOrigin(CGPoint point, CGFloat angle, CGPoint origin);
inline CGPoint CGPointRotate90DegreesCW(CGPoint point);
inline CGPoint CGPointRotate90DegreesCWAroundPoint(CGPoint point, CGPoint origin);
inline CGPoint CGPointRotate90DegreesCC(CGPoint point);
inline CGPoint CGPointRotate90DegreesCCAroundPoint(CGPoint point, CGPoint origin);
