//
//  AGKMatrix+AGKVector3D.h
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/20/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import "AGKMatrix.h"
#import "AGKVector3D.h"

@interface AGKMatrix (AGKVector3D)

/**
 *  Creates and returns a 1x3 matrix containing the members and from the given 
 *  vector.
 *
 *  @param vector The vector with which to initialize the matrix's members.
 *
 *  @return A new matrix containing the values found in `vector`
 */
+ (instancetype)matrixWithVector3D:(AGKVector3D)vector;

/**
 *  Returns a matrix multiplied by the given 3D vector.
 *
 *  @param vector The vector to multipy against.
 *
 *  @return A 1x3 matrix resulting from multiplying the reciver with the
 *  specified vector.
 */
- (AGKMatrix *)matrixByMultiplyingWithVector3D:(AGKVector3D)vector;

@end
