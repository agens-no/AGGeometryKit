//
//  UIView+AngleConverter.m
//  ViewAngleTest
//
//  Created by Odd Magne Hågensen on 12.03.13.
//  Copyright (c) 2013 Odd Magne Hågensen. All rights reserved.
//

#import "UIView+AngleConverter.h"
#import "CGGeometry+Extra.h"

@implementation UIView (AngleConverter)

- (CGFloat)convertAngle:(CGFloat)angle toView:(UIView *)view
{
    CGPoint p1n = CGPointMake(0, 0);
    CGPoint p2n = CGPointMake(0, 1000);
    
    CGPoint p1r = [self convertPoint:p1n toView:view];
    CGPoint p2r = [self convertPoint:p2n toView:view];
    
    CGPoint v1 = CGPointMake(p2n.x - p1n.x, p2n.y - p1n.y);
    CGPoint v2 = CGPointMake(p2r.x - p1r.x, p2r.y - p1r.y);
    
    CGPoint v1Normalized = CGPointVectorNormalize(v1);
    CGPoint v2Normalized = CGPointVectorNormalize(v2);
    
    CGFloat crossZ = CGPointVectorCrossProductZComponent(v1Normalized, v2Normalized);
    CGFloat cosAngleInRelation = CGPointVectorDotProduct(v1Normalized, v2Normalized);
    CGFloat angleInRelation = acosf(cosAngleInRelation);
    
    if (crossZ > 0.0f)
    {
        angleInRelation = -angleInRelation;
    }
    
    return angleInRelation;
}

- (CGFloat)convertAngleOfViewInRelationToView:(UIView *)view
{
    return [self convertAngle:0.0 toView:view];
}

@end
