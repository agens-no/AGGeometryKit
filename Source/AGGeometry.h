//
//  AGGeometry.h
//  no.agens.foldshadow
//
//  Created by Håvard Fossli on 16.08.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://processingjs.nihongoresources.com/bezierinfo/

typedef enum VGAxis {
    VGAxisX,
    VGAxisY,
    VGAxizZ,
} VGAxis;

typedef enum VGSide {
    VGSideTop = 1 << 0,
    VGSideBottom = 1 << 1,
    VGSideLeft = 1 << 2,
    VGSideRight = 1 << 3,
} VGSide;

typedef enum {
    AGCornerTopLeft = VGSideTop | VGSideLeft,
    AGCornerTopRight = VGSideTop | VGSideRight,
    AGCornerBottomLeft = VGSideBottom | VGSideLeft,
    AGCornerBottomRight = VGSideBottom | VGSideRight,
} AGCorner;

BOOL AGCornerIsOnSide(AGCorner corner, VGSide side);
CGPoint AGCornerConvertToAnchorPoint(AGCorner corner);
CGPoint AGCornerConvertToPointForRect(AGCorner corner, CGRect rect);

CGPoint CGPointGetPointForAnchorPointInRect(CGPoint anchor, CGRect rect);
CGPoint CGPointGetAnchorPointForPointInRect(CGPoint point, CGRect rect);
CGPoint CGPointForCenterInRect(CGRect rect);

inline double CGPointDistanceBetweenPoints(CGPoint p1, CGPoint p2);
inline CGPoint CGPointNormalizedDistance(CGPoint p1, CGPoint p2);

inline double CGSizeGetAspectRatio(CGSize size);
inline BOOL CGSizeAspectIsWiderThanCGSize(CGSize size1, CGSize size2);
CGSize CGSizeAdjustOuterSizeToFitInnerSize(CGSize outer, CGSize inner);

inline BOOL CGRectGotAnyNanValues(CGRect rect);
inline BOOL CGSizeGotAnyNanValues(CGSize size);
inline BOOL CGPointGotAnyNanValues(CGPoint origin);

inline CGPoint CGPointAddSize(CGPoint p, CGSize s);
inline CGRect CGRectMakeWithSize(CGSize size);
inline CGSize CGSizeGetHalf(CGSize size);
inline CGSize CGSizeFlipped(CGSize size);
inline CGRect CGRectNewWidth(CGRect rect, CGFloat newWidth);
inline CGRect CGRectNewHeight(CGRect rect, CGFloat newHeight);

CGRect CGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints);

CGSize CGSizeInterpolate(CGSize size1, CGSize size2, double progress);
CGPoint CGPointInterpolate(CGPoint point1, CGPoint point2, double progress);
CGRect CGRectInterpolate(CGRect rect1, CGRect rect2, double progress);

BOOL getLineIntersection(double p0_x,
                         double p0_y,
                         double p1_x,
                         double p1_y,
                         double p2_x,
                         double p2_y,
                         double p3_x,
                         double p3_y,
                         double *out_i_x,
                         double *out_i_y);
