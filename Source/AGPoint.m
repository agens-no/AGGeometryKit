//
//  AGPoint.m
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGPoint.h"
#import "AGMath.h"
#import "AGGeometry.h"

typedef union {
    CGPoint cg;
    AGPoint ag;
} AGPointUnionCGPoint;


const AGPoint AGPointZero = (AGPoint){0, 0};

extern BOOL AGPointEqual(AGPoint p1, AGPoint p2)
{
    return p1.x == p2.x && p1.x == p2.x;
}

extern BOOL AGPointEqualToCGPoint(AGPoint p1, CGPoint p2)
{
    return p1.x == p2.x && p1.x == p2.x;
}

extern AGPoint AGPointMakeWithCGPoint(CGPoint p)
{
    AGPointUnionCGPoint uPoint;
    uPoint.cg = p;
    return uPoint.ag;
}

extern AGPoint AGPointMake(double x, double y)
{
    return (AGPoint){x, y};
}

extern AGPoint AGPointInterpolate(AGPoint p1, AGPoint p2, double progress)
{
    AGPoint result;
    result.x = valueInterpolate(p1.x, p2.x, progress);
    result.y = valueInterpolate(p1.y, p2.y, progress);
    return result;
}

NSString * NSStringFromAGPoint(AGPoint p)
{
    return [NSString stringWithFormat:@"{%f, %f}", p.x, p.y];
}

