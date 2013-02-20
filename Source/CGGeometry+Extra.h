//
//  AGGeometry.h
//  no.agens.foldshadow
//
//  Created by Håvard Fossli on 16.08.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://processingjs.nihongoresources.com/bezierinfo/

CGPoint CGPointGetPointForAnchorPointInRect(CGPoint anchor, CGRect rect);
CGPoint CGPointGetAnchorPointForPointInRect(CGPoint point, CGRect rect);
CGPoint CGPointForCenterInRect(CGRect rect);
inline CGFloat CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2);
inline CGPoint CGPointNormalizedDistance(CGPoint p1, CGPoint p2);
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
CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress);
CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress);
CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress);
