//
//  CATransformQuadrectal.m
//  VG
//
//  Created by Håvard Fossli on 06.12.12.
//
//

#import "AGQuadrilateral.h"
#import "AGMath.h"
#import "AGGeometry.h"


/*
 
 
 REFERENCES FOR FURTHER STUDYING
 http://pastebin.com/90De4QqT
 http://stackoverflow.com/questions/9470493/transforming-a-rectangle-image-into-a-quadrilateral-using-a-catransform3d
 http://stackoverflow.com/questions/9088882/return-catransform3d-to-map-quadrilateral-to-quadrilateral
 
 
 
 
 */



const AGQuadrilateral AGQuadrilateralZero = { (AGPoint){0, 0}, (AGPoint){0, 0}, (AGPoint){0, 0}, (AGPoint){0, 0} };

extern BOOL AGQuadrilateralEqual(AGQuadrilateral q1, AGQuadrilateral q2)
{
    if(AGPointEqual(q1.tl, q2.tl)
       &&
       AGPointEqual(q1.tr, q2.tr)
       &&
       AGPointEqual(q1.bl, q2.bl)
       &&
       AGPointEqual(q1.br, q2.br))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

BOOL AGQuadrilateralIsValid(AGQuadrilateral q)
{
    BOOL isConvex = getLineIntersection(q.tl.x, q.tl.y, q.tr.x, q.tr.y, q.br.x, q.br.y, q.bl.x, q.bl.y, NULL, NULL);
    return isConvex;
}

extern AGQuadrilateral AGQuadrilateralMove(AGQuadrilateral q, double x, double y)
{
    q.tl.x += x;
    q.tr.x += x;
    q.bl.x += x;
    q.br.x += x;
    q.tl.y += y;
    q.tr.y += y;
    q.bl.y += y;
    q.br.y += y;
    return q;
}

extern AGQuadrilateral AGQuadrilateralInsetLeft(AGQuadrilateral q, double inset)
{
    q.tl.x += inset;
    q.bl.x += inset;
    return q;
}

extern AGQuadrilateral AGQuadrilateralInsetRight(AGQuadrilateral q, double inset)
{
    q.tr.x -= inset;
    q.br.x -= inset;
    return q;
}

extern AGQuadrilateral AGQuadrilateralInsetTop(AGQuadrilateral q, double inset)
{
    q.tl.x += inset;
    q.tr.y += inset;
    return q;
}

extern AGQuadrilateral AGQuadrilateralInsetBottom(AGQuadrilateral q, double inset)
{
    q.tl.x -= inset;
    q.tr.y -= inset;
    return q;
}

extern AGQuadrilateral AGQuadrilateralMirror(AGQuadrilateral q, BOOL x, BOOL y)
{
    AGQuadrilateral mirroredQ = q;
    if(x)
    {
        mirroredQ.tl.x = q.tr.x;
        mirroredQ.tr.x = q.tl.x;
        mirroredQ.bl.x = q.br.x;
        mirroredQ.br.x = q.bl.x;
    }
    if(y)
    {
        mirroredQ.tl.y = q.tr.y;
        mirroredQ.tr.y = q.tl.y;
        mirroredQ.bl.y = q.br.y;
        mirroredQ.br.y = q.bl.y;
    }
    return mirroredQ;
}

extern AGQuadrilateral AGQuadrilateralMakeWithCGPoints(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl)
{
    AGQuadrilateral q;
    q.tl = AGPointMakeWithCGPoint(tl);
    q.tr = AGPointMakeWithCGPoint(tr);
    q.br = AGPointMakeWithCGPoint(br);
    q.bl = AGPointMakeWithCGPoint(bl);
    return q;
}

extern AGQuadrilateral AGQuadrilateralMakeWithCGRect(CGRect rect)
{
    AGQuadrilateral q;
    q.tl.x = CGRectGetMinX(rect);
    q.tl.y = CGRectGetMinY(rect);
    q.tr.x = CGRectGetMaxX(rect);
    q.tr.y = CGRectGetMinY(rect);
    q.br.x = CGRectGetMaxX(rect);
    q.br.y = CGRectGetMaxY(rect);
    q.bl.x = CGRectGetMinX(rect);
    q.bl.y = CGRectGetMaxY(rect);
    return q;
}

extern AGQuadrilateral AGQuadrilateralMakeWithCGSize(CGSize size)
{
    AGQuadrilateral q = AGQuadrilateralZero;
    q.tr.x = size.width;
    q.br.x = size.width;
    q.bl.y = size.height;
    q.br.y = size.height;
    return q;
}

extern double AGQuadrilateralGetSmallestX(AGQuadrilateral q)
{
    double values[4];
    AGQuadrilateralGetYValues(q, values);
    return doubleLowest(values, 4);
}

extern double AGQuadrilateralGetBiggestX(AGQuadrilateral q)
{
    double values[4];
    AGQuadrilateralGetYValues(q, values);
    return doubleHighest(values, 4);
}

extern double AGQuadrilateralGetSmallestY(AGQuadrilateral q)
{
    double values[4];
    AGQuadrilateralGetYValues(q, values);
    return doubleLowest(values, 4);
}

extern double AGQuadrilateralGetBiggestY(AGQuadrilateral q)
{
    double values[4];
    AGQuadrilateralGetYValues(q, values);
    return doubleHighest(values, 4);
}

extern CGRect AGQuadrilateralGetBoundingRect(AGQuadrilateral q)
{
    double xValues[4];
    double yValues[4];
    AGQuadrilateralGetXValues(q, xValues);
    AGQuadrilateralGetYValues(q, yValues);
    
    CGFloat xmin = doubleLowest(xValues, 4);
    CGFloat xmax = doubleLowest(xValues, 4);
    CGFloat ymin = doubleLowest(yValues, 4);
    CGFloat ymax = doubleLowest(yValues, 4);
    
    CGRect rect;
    rect.origin.x = xmin;
    rect.origin.y = ymin;
    rect.size.width = xmax - xmin;
    rect.size.height = ymax - ymin;
    
    return rect;
}

extern CGSize AGQuadrilateralGetSize(AGQuadrilateral q)
{
    CGRect smallestRect = AGQuadrilateralGetBoundingRect(q);
    return smallestRect.size;
}

void AGQuadrilateralGetXValues(AGQuadrilateral q, double *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = q.v[i];
        out_values[i] = p.x;
    }
}

void AGQuadrilateralGetYValues(AGQuadrilateral q, double *out_values)
{
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = q.v[i];
        out_values[i] = p.y;
    }
}

extern AGQuadrilateral AGQuadrilateralInterpolation(AGQuadrilateral q1, AGQuadrilateral q2, double progress)
{
    AGQuadrilateral i;
    i.tl = AGPointInterpolate(q1.tl, q2.tl, progress);
    i.tr = AGPointInterpolate(q1.tr, q2.tr, progress);
    i.bl = AGPointInterpolate(q1.bl, q2.bl, progress);
    i.br = AGPointInterpolate(q1.br, q2.br, progress);
    return i;
}

extern NSString * NSStringFromAGQuadrilateral(AGQuadrilateral q)
{
    return [NSString stringWithFormat:@"tl: %@,\n\t"
            "tr: %@,\n\t"
            "br: %@,\n\t"
            "bl: %@",
            NSStringFromAGPoint(q.tl),
            NSStringFromAGPoint(q.tr),
            NSStringFromAGPoint(q.br),
            NSStringFromAGPoint(q.bl)
            ];
}

// Taken from https://github.com/Ciechan/BCGenieEffect/blob/master/UIView%2BGenie.m
// Which derives from http://stackoverflow.com/a/12820877/558816
CATransform3D CATransform3DMakeRectToQuadrilateral(CGRect rect, AGQuadrilateral q)
{
    double W = rect.size.width;
    double H = rect.size.height;
    
    double x1a = q.tl.x;
    double y1a = q.tl.y;
    
    double x2a = q.tr.x;
    double y2a = q.tr.y;
    
    double x3a = q.bl.x;
    double y3a = q.bl.y;
    
    double x4a = q.br.x;
    double y4a = q.br.y;
    
    double y21 = y2a - y1a,
    y32 = y3a - y2a,
    y43 = y4a - y3a,
    y14 = y1a - y4a,
    y31 = y3a - y1a,
    y42 = y4a - y2a;
    
    double a = -H*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42);
    double b = W*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    double c = - H*W*x1a*(x4a*y32 - x3a*y42 + x2a*y43);
    
    double d = H*(-x4a*y21*y3a + x2a*y1a*y43 - x1a*y2a*y43 - x3a*y1a*y4a + x3a*y2a*y4a);
    double e = W*(x4a*y2a*y31 - x3a*y1a*y42 - x2a*y31*y4a + x1a*y3a*y42);
    double f = -(W*(x4a*(H*y1a*y32) - x3a*(H)*y1a*y42 + H*x2a*y1a*y43));
    
    double g = H*(x3a*y21 - x4a*y21 + (-x1a + x2a)*y43);
    double h = W*(-x2a*y31 + x4a*y31 + (x1a - x3a)*y42);
    double i = H*(W*(-(x3a*y2a) + x4a*y2a + x2a*y3a - x4a*y3a - x2a*y4a + x3a*y4a));
    
    const double kEpsilon = 0.0001;
    
    if(fabs(i) < kEpsilon)
    {
        i = kEpsilon* (i > 0 ? 1.0 : -1.0);
    }
    
    CATransform3D transform = {a/i, d/i, 0, g/i, b/i, e/i, 0, h/i, 0, 0, 1, 0, c/i, f/i, 0, 1.0};
    
    return transform;
}



@implementation NSValue (AGQuadrilateralAdditions)

+ (NSValue *)valueWithAGQuadrilateral:(AGQuadrilateral)q
{
    NSValue *value = [NSValue value:&q withObjCType:@encode(AGQuadrilateral)];
    return value;
}

- (AGQuadrilateral)AGQuadrilateralValue
{
    AGQuadrilateral q;
    [self getValue:&q];
    return q;
}

@end

