//
//  AGKMatrix+GLKit.h
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/17/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import "AGKMatrix.h"
#import <GLKit/GLKit.h>

@interface AGKMatrix (GLKit)

+ (instancetype)matrixWithGLKMatrix2:(GLKMatrix2)glkMatrix;
+ (instancetype)matrixWithGLKMatrix3:(GLKMatrix3)glkMatrix;
+ (instancetype)matrixWithGLKMatrix4:(GLKMatrix4)glkMatrix;

- (GLKMatrix2)glkMatrix2Value;
- (GLKMatrix3)glkMatrix3Value;
- (GLKMatrix4)glkMatrix4Value;

@end
