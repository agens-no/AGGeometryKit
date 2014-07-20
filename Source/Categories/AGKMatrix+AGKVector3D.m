//
//  AGKMatrix+AGKVector3D.m
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/20/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import "AGKMatrix+AGKVector3D.h"

@implementation AGKMatrix (AGKVector3D)

+ (instancetype)matrixWithVector3D:(AGKVector3D)vector {
    return [(AGKMatrix *)[self alloc] initWithColumns:1 rows:3 members:@[@(vector.x), @(vector.y), @(vector.z)]];
}

- (AGKMatrix *)matrixByMultiplyingWithVector3D:(AGKVector3D)vector {
    if (self.columnCount != 3) {
        return nil;
    }
    
    AGKMatrix *vectorMatrix = [[AGKMatrix alloc] initWithColumns:1 rows:3 members:@[@(vector.x), @(vector.y), @(vector.z)]];
    return [self matrixByMultiplyingWithMatrix:vectorMatrix];
}

@end
