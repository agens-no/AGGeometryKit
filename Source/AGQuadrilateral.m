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

CATransform3D CATransform3DMakeRectToQuadrilateral(CGRect rect, AGQuadrilateral q)
{
    double X = rect.origin.x;
    double Y = rect.origin.y;
    double W = rect.size.width;
    double H = rect.size.height;
    
    double y21 = q.tr.y - q.tl.y;
    double y32 = q.bl.y - q.tr.y;
    double y43 = q.br.y - q.bl.y;
    double y14 = q.tl.y - q.br.y;
    double y31 = q.bl.y - q.tl.y;
    double y42 = q.br.y - q.tr.y;
    
    double a = -H*(q.tr.x*q.bl.x*y14 + q.tr.x*q.br.x*y31 - q.tl.x*q.br.x*y32 + q.tl.x*q.bl.x*y42);
    double b = W*(q.tr.x*q.bl.x*y14 + q.bl.x*q.br.x*y21 + q.tl.x*q.br.x*y32 + q.tl.x*q.tr.x*y43);
    double c = H*X*(q.tr.x*q.bl.x*y14 + q.tr.x*q.br.x*y31 - q.tl.x*q.br.x*y32 + q.tl.x*q.bl.x*y42) - H*W*q.tl.x*(q.br.x*y32 - q.bl.x*y42 + q.tr.x*y43) - W*Y*(q.tr.x*q.bl.x*y14 + q.bl.x*q.br.x*y21 + q.tl.x*q.br.x*y32 + q.tl.x*q.tr.x*y43);
    
    double d = H*(-q.br.x*y21*q.bl.y + q.tr.x*q.tl.y*y43 - q.tl.x*q.tr.y*y43 - q.bl.x*q.tl.y*q.br.y + q.bl.x*q.tr.y*q.br.y);
    double e = W*(q.br.x*q.tr.y*y31 - q.bl.x*q.tl.y*y42 - q.tr.x*y31*q.br.y + q.tl.x*q.bl.y*y42);
    double f = -(W*(q.br.x*(Y*q.tr.y*y31 + H*q.tl.y*y32) - q.bl.x*(H + Y)*q.tl.y*y42 + H*q.tr.x*q.tl.y*y43 + q.tr.x*Y*(q.tl.y - q.bl.y)*q.br.y + q.tl.x*Y*q.bl.y*(-q.tr.y + q.br.y)) - H*X*(q.br.x*y21*q.bl.y - q.tr.x*q.tl.y*y43 + q.bl.x*(q.tl.y - q.tr.y)*q.br.y + q.tl.x*q.tr.y*(-q.bl.y + q.br.y)));
    
    double g = H*(q.bl.x*y21 - q.br.x*y21 + (-q.tl.x + q.tr.x)*y43);
    double h = W*(-q.tr.x*y31 + q.br.x*y31 + (q.tl.x - q.bl.x)*y42);
    double i = W*Y*(q.tr.x*y31 - q.br.x*y31 - q.tl.x*y42 + q.bl.x*y42) + H*(X*(-(q.bl.x*y21) + q.br.x*y21 + q.tl.x*y43 - q.tr.x*y43) + W*(-(q.bl.x*q.tr.y) + q.br.x*q.tr.y + q.tr.x*q.bl.y - q.br.x*q.bl.y - q.tr.x*q.br.y + q.bl.x*q.br.y));
    
    if(fabs(i) < 0.00001)
    {
        i = 0.00001;
    }
    
    CATransform3D t = CATransform3DIdentity;
    
    t.m11 = a / i;
    t.m12 = d / i;
    t.m13 = 0;
    t.m14 = g / i;
    t.m21 = b / i;
    t.m22 = e / i;
    t.m23 = 0;
    t.m24 = h / i;
    t.m31 = 0;
    t.m32 = 0;
    t.m33 = 1;
    t.m34 = 0;
    t.m41 = c / i;
    t.m42 = f / i;
    t.m43 = 0;
    t.m44 = i / i;
    
    return t;
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

