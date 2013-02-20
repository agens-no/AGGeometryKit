//
//  AGLine.h
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGPoint.h"

typedef union AGLine {
    struct { AGPoint start, end; };
    double v[2];
} AGLine;

extern const AGLine AGLineZero;
inline AGLine AGLineMake(AGPoint start, AGPoint end);
inline AGLine AGLineMakeWithCGPoint(CGPoint start, CGPoint end);
inline double AGLineLength(AGLine l);
BOOL AGLineIntersection(AGLine l1, AGLine l2, AGPoint *out_pointOfIntersection);