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

// CGPoint

inline BOOL AGCGPointGotAnyNanValues(CGPoint origin);
inline CGPoint AGCGPointModified(CGPoint point, CGPoint (^block)(CGPoint point));

inline CGPoint AGCGPointAdd(CGPoint p1, CGPoint p2);
inline CGPoint AGCGPointAddSize(CGPoint p, CGSize s);
inline CGPoint AGCGPointSubtract(CGPoint p1, CGPoint p2);
inline CGPoint AGCGPointMultiply(CGPoint p1, CGFloat factor);
inline CGPoint AGCGPointDivide(CGPoint p1, CGFloat factor);
inline CGPoint AGCGPointNormalize(CGPoint v);
inline CGFloat AGCGPointDotProduct(CGPoint p1, CGPoint p2);
inline CGFloat AGCGPointCrossProductZComponent(CGPoint v1, CGPoint v2);
inline CGFloat AGCGPointLength(CGPoint v);
inline CGFloat AGCGPointLengthBetween(CGPoint p1, CGPoint p2);

CGPoint AGCGPointApplyCATransform3D(CGPoint point,
                                    CATransform3D transform,
                                    CGPoint anchorPoint,
                                    CATransform3D parentSublayerTransform);

inline CGPoint AGCGPointRotate(CGPoint point, CGFloat angle);
inline CGPoint AGCGPointRotateAroundOrigin(CGPoint point, CGFloat angle, CGPoint origin);
inline CGPoint AGCGPointRotate90DegreesCW(CGPoint point);
inline CGPoint AGCGPointRotate90DegreesCWAroundPoint(CGPoint point, CGPoint origin);
inline CGPoint AGCGPointRotate90DegreesCC(CGPoint point);
inline CGPoint AGCGPointRotate90DegreesCCAroundPoint(CGPoint point, CGPoint origin);

inline CGPoint AGCGPointConvertFromAnchorPoint(CGPoint anchor, CGRect rect);
inline CGPoint AGCGPointConvertToAnchorPoint(CGPoint point, CGRect rect);

inline CGPoint AGCGPointInterpolate(CGPoint point1, CGPoint point2, double progress);


// CGSize

inline BOOL AGCGSizeGotAnyNanValues(CGSize size);
inline CGSize AGCGSizeModified(CGSize size, CGSize (^block)(CGSize size));

inline CGSize AGCGSizeHalf(CGSize size);
inline CGSize AGCGSizeSwitchAxis(CGSize size);
inline double AGCGSizeAspectRatio(CGSize size);
inline CGSize AGCGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner);
inline BOOL AGCGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2);
inline CGFloat AGCGSizeScalarToAspectFit(CGSize sizeToFit, CGSize container);
inline CGFloat AGCGSizeScalarToAspectFill(CGSize sizeToFill, CGSize container);

inline CGSize AGCGSizeInterpolate(CGSize size1, CGSize size2, double progress);


// CGRect

inline BOOL AGCGRectGotAnyNanValues(CGRect rect);
inline CGRect AGCGRectModified(CGRect rect, CGRect (^block)(CGRect rect));
CGSize AGRectGapBetween(CGRect rect1, CGRect rect2);
inline CGPoint AGCGRectGetMid(CGRect rect);

CGRect AGCGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints);
inline CGRect AGCGRectMakeWithSize(CGSize size);
inline CGRect AGCGRectWithSize(CGRect rect, CGSize newSize);
inline CGRect AGCGRectWithWidth(CGRect rect, CGFloat newWidth);
inline CGRect AGCGRectWithHeight(CGRect rect, CGFloat newHeight);
inline CGRect AGCGRectWithOrigin(CGRect rect, CGPoint origin);
inline CGRect AGCGRectWithOriginMinX(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMinY(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMaxY(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMaxX(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMidX(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMidY(CGRect rect, CGFloat value);
inline CGRect AGCGRectWithOriginMid(CGRect rect, CGPoint origin);

inline CGRect AGCGRectInterpolate(CGRect rect1, CGRect rect2, double progress);

