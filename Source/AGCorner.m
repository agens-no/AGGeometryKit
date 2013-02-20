//
//  AGCorner.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGCorner.h"

extern BOOL AGCornerIsOnSide(AGCorner corner, AGSide side)
{
    return (corner & side) == side;
}

CGPoint AGCornerConvertToAnchorPoint(AGCorner corner)
{
    switch (corner) {
        case AGCornerTopLeft:
            return CGPointMake(0, 0);
            break;
        case AGCornerTopRight:
            return CGPointMake(1, 0);
            break;
        case AGCornerBottomLeft:
            return CGPointMake(0, 1);
            break;
        case AGCornerBottomRight:
            return CGPointMake(1, 1);
            break;
    }
}

CGPoint AGCornerConvertToPointForRect(AGCorner corner, CGRect rect)
{
    CGPoint anchor = AGCornerConvertToAnchorPoint(corner);
    CGPoint p = CGPointGetPointForAnchorPointInRect(anchor, rect);
    return p;
}
