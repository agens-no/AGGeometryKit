//
//  AGPoint.h
//  AGQuad
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

// Using AGPoint for better precision when calculating transform for quadrilaterals

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
NSString * NSStringFromAGPoint(AGPoint p);