//
//  AGPoint.h
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef union AGPoint {
    struct { double x, y; };
    double v[2];
} AGPoint;

extern const AGPoint AGPointZero;
inline BOOL AGPointEqual(AGPoint p1, AGPoint p2);
inline BOOL AGPointEqualToCGPoint(AGPoint p1, CGPoint p2);
inline AGPoint AGPointMakeWithCGPoint(CGPoint p);
inline AGPoint AGPointMake(double x, double y);
inline AGPoint AGPointInterpolate(AGPoint p1, AGPoint p2, double progress);
NSString * NSStringFromAGPoint(AGPoint p);