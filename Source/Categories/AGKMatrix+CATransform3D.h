//
//  AGKMatrix+CATransform3D.h
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/17/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import "AGKMatrix.h"

@interface AGKMatrix (CATransform3D)

+ (instancetype)matrixWithCATransform3D:(CATransform3D)transform;

- (CATransform3D)caTransform3DValue;

@end
