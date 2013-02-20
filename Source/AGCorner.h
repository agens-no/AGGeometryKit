//
//  AGCorner.h
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "CGGeometry+Extra.h"

typedef enum AGSide {
    AGSideTop = 1 << 0,
    AGSideBottom = 1 << 1,
    AGSideLeft = 1 << 2,
    AGSideRight = 1 << 3,
} AGSide;

typedef enum {
    AGCornerTopLeft = AGSideTop | AGSideLeft,
    AGCornerTopRight = AGSideTop | AGSideRight,
    AGCornerBottomLeft = AGSideBottom | AGSideLeft,
    AGCornerBottomRight = AGSideBottom | AGSideRight,
} AGCorner;

inline BOOL AGCornerIsOnSide(AGCorner corner, AGSide side);
CGPoint AGCornerConvertToAnchorPoint(AGCorner corner);
CGPoint AGCornerConvertToPointForRect(AGCorner corner, CGRect rect);