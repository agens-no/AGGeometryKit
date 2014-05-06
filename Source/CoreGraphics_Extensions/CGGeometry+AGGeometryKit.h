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

inline BOOL AGKCGPointGotAnyNanValues(CGPoint origin);
inline CGPoint AGKCGPointModified(CGPoint point, CGPoint (^block)(CGPoint point));

inline CGPoint AGKCGPointAdd(CGPoint p1, CGPoint p2);
inline CGPoint AGKCGPointAddSize(CGPoint p, CGSize s);
inline CGPoint AGKCGPointSubtract(CGPoint p1, CGPoint p2);
inline CGPoint AGKCGPointMultiply(CGPoint p1, CGFloat factor);
inline CGPoint AGKCGPointDivide(CGPoint p1, CGFloat factor);
inline CGPoint AGKCGPointNormalize(CGPoint v);
inline CGFloat AGKCGPointDotProduct(CGPoint p1, CGPoint p2);
inline CGFloat AGKCGPointCrossProductZComponent(CGPoint v1, CGPoint v2);
inline CGFloat AGKCGPointLength(CGPoint v);
inline CGFloat AGKCGPointLengthBetween(CGPoint p1, CGPoint p2);

CGPoint AGKCGPointApplyCATransform3D(CGPoint point,
                                    CATransform3D transform,
                                    CGPoint anchorPoint,
                                    CATransform3D parentSublayerTransform);

inline CGPoint AGKCGPointRotate(CGPoint point, CGFloat angle);
inline CGPoint AGKCGPointRotateAroundOrigin(CGPoint point, CGFloat angle, CGPoint origin);
inline CGPoint AGKCGPointRotate90DegreesCW(CGPoint point);
inline CGPoint AGKCGPointRotate90DegreesCWAroundPoint(CGPoint point, CGPoint origin);
inline CGPoint AGKCGPointRotate90DegreesCC(CGPoint point);
inline CGPoint AGKCGPointRotate90DegreesCCAroundPoint(CGPoint point, CGPoint origin);

inline CGPoint AGKCGPointConvertFromAnchorPoint(CGPoint anchor, CGRect rect);
inline CGPoint AGKCGPointConvertToAnchorPoint(CGPoint point, CGRect rect);

inline CGPoint AGKCGPointInterpolate(CGPoint point1, CGPoint point2, double progress);


// CGSize

inline BOOL AGKCGSizeGotAnyNanValues(CGSize size);
inline CGSize AGKCGSizeModified(CGSize size, CGSize (^block)(CGSize size));

inline CGSize AGKCGSizeHalf(CGSize size);
inline CGSize AGKCGSizeSwitchAxis(CGSize size);
inline double AGKCGSizeAspectRatio(CGSize size);
inline CGSize AGKCGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner);
inline BOOL AGKCGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2);
inline CGFloat AGKCGSizeScalarToAspectFit(CGSize sizeToFit, CGSize container);
inline CGFloat AGKCGSizeScalarToAspectFill(CGSize sizeToFill, CGSize container);

inline CGSize AGKCGSizeInterpolate(CGSize size1, CGSize size2, double progress);


// CGRect

inline BOOL AGKCGRectGotAnyNanValues(CGRect rect);
inline CGRect AGKCGRectModified(CGRect rect, CGRect (^block)(CGRect rect));
CGSize AGRectGapBetween(CGRect rect1, CGRect rect2);
inline CGPoint AGKCGRectGetMid(CGRect rect);

CGRect AGKCGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints);
inline CGRect AGKCGRectMakeWithSize(CGSize size);
inline CGRect AGKCGRectWithSize(CGRect rect, CGSize newSize);
inline CGRect AGKCGRectWithWidth(CGRect rect, CGFloat newWidth);
inline CGRect AGKCGRectWithHeight(CGRect rect, CGFloat newHeight);
inline CGRect AGKCGRectWithOrigin(CGRect rect, CGPoint origin);
inline CGRect AGKCGRectWithOriginMinX(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMinY(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMaxY(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMaxX(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMidX(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMidY(CGRect rect, CGFloat value);
inline CGRect AGKCGRectWithOriginMid(CGRect rect, CGPoint origin);

inline CGRect AGKCGRectInterpolate(CGRect rect1, CGRect rect2, double progress);

