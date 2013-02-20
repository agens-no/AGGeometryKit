//
//  AGPoint.m
//  AGQuad
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGPoint.h"
#import "AGMath.h"

const AGPoint AGPointZero = (AGPoint){0, 0};

extern BOOL AGPointEqual(AGPoint p1, AGPoint p2)
{
    return p1.x == p2.x && p1.x == p2.x;
}

extern BOOL AGPointEqualToCGPoint(AGPoint p1, CGPoint p2)
{
    return ((CGFloat)p1.x) == p2.x && ((CGFloat)p1.x) == p2.x;
}

extern AGPoint AGPointMakeWithCGPoint(CGPoint cg)
{
    AGPoint ag = {cg.x, cg.y};
    return ag;
}

extern AGPoint AGPointMakeWithCGPointZeroFill(CGPoint cg)
{
    AGPoint ag = {floatToDoubleZeroFill(cg.x), floatToDoubleZeroFill(cg.y)};
    return ag;
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

extern AGPoint AGPointSubtract(AGPoint p1, AGPoint p2)
{
    return (AGPoint){p1.x - p2.x, p1.y - p2.y};
}

extern AGPoint AGPointAdd(AGPoint p1, AGPoint p2)
{
    return (AGPoint){p1.x + p2.x, p1.y + p2.y};
}

extern AGPoint AGPointMultiply(AGPoint p1, double factor)
{
    return (AGPoint){p1.x * factor, p1.y * factor};
}

extern double AGPointDotProduct(AGPoint p1, AGPoint p2)
{
    return (p1.x * p2.x) + (p1.y * p2.y);
}

extern double AGPointCrossProduct(AGPoint p1, AGPoint p2)
{
    return (p1.x * p2.y) - (p1.y * p2.x);
}

extern CGPoint AGPointAsCGPoint(AGPoint p)
{
    return CGPointMake(p.x, p.y);
}

NSString * NSStringFromAGPoint(AGPoint p)
{
    return [NSString stringWithFormat:@"{%f, %f}", p.x, p.y];
}

