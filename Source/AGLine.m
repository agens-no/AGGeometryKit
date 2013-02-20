//
//  AGLine.m
//  AGQuad
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGLine.h"

const AGLine AGLineZero = (AGLine){(AGPoint){0.0, 0.0}, (AGPoint){0.0, 0.0}};

extern AGLine AGLineMake(AGPoint start, AGPoint end)
{
    return (AGLine){start, end};
}

extern AGLine AGLineMakeWithCGPoint(CGPoint start, CGPoint end)
{
    return AGLineMake(AGPointMakeWithCGPointZeroFill(start), AGPointMakeWithCGPointZeroFill(end));
}

extern double AGLineLength(AGLine l)
{
    return sqrt(pow(l.start.x - l.end.x, 2.0f) + pow(l.start.y - l.end.y, 2.0f));
}

BOOL AGLineIntersection(AGLine l1, AGLine l2, AGPoint *out_pointOfIntersection)
{
    // http://stackoverflow.com/a/565282/202451

    AGPoint p = l1.start;
    AGPoint q = l2.start;
    AGPoint r = AGPointSubtract(l1.end, l1.start);
    AGPoint s = AGPointSubtract(l2.end, l2.start);
    
    double s_r_crossProduct = AGPointCrossProduct(r, s);
    double t = AGPointCrossProduct(AGPointSubtract(q, p), s) / s_r_crossProduct;
    double u = AGPointCrossProduct(AGPointSubtract(q, p), r) / s_r_crossProduct;
    
    if(t < 0 || t > 1.0 || u < 0 || u > 1.0)
    {
        if(out_pointOfIntersection != NULL)
        {
            *out_pointOfIntersection = AGPointZero;
        }
        return NO;
    }
    else
    {
        if(out_pointOfIntersection != NULL)
        {
            AGPoint i = AGPointAdd(p, AGPointMultiply(r, t));
            *out_pointOfIntersection = i;
        }
        return YES;
    }
}