//
//  AGKMatrix+GLKit.m
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/17/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import "AGKMatrix+GLKit.h"

@implementation AGKMatrix (GLKit)

+ (instancetype)matrixWithGLKMatrix2:(GLKMatrix2)glkMatrix
{
	AGKMatrix *myself = [(AGKMatrix *)[self alloc] initWithColumns:2 rows:2 members:nil];
	for (NSUInteger memberIndex = 0; memberIndex < (2 * 2); memberIndex++)
    {
		myself[memberIndex] = @(glkMatrix.m[memberIndex]);
	}
	
	return myself;
}

+ (instancetype)matrixWithGLKMatrix3:(GLKMatrix3)glkMatrix
{
	AGKMatrix *myself = [(AGKMatrix *)[self alloc] initWithColumns:3 rows:3 members:nil];
	for (NSUInteger memberIndex = 0; memberIndex < (3 * 3); memberIndex++)
    {
		myself[memberIndex] = @(glkMatrix.m[memberIndex]);
	}
	
	return myself;
}

+ (instancetype)matrixWithGLKMatrix4:(GLKMatrix4)glkMatrix
{
	AGKMatrix *myself = [(AGKMatrix *)[self alloc] initWithColumns:4 rows:4 members:nil];
	for (NSUInteger memberIndex = 0; memberIndex < (4 * 4); memberIndex++)
    {
		myself[memberIndex] = @(glkMatrix.m[memberIndex]);
	}
	
	return myself;
}

- (GLKMatrix2)glkMatrix2Value
{
	GLKMatrix2 glkMatrix;
	
	for (NSUInteger absoluteIndex = 0; absoluteIndex < (2 * 2); absoluteIndex++)
    {
		double mValue;
		if (absoluteIndex < self.count)
        {
			mValue = [self[absoluteIndex] floatValue];
		}
        else
        {
			mValue = [self.defaultMember floatValue];
		}
		
		glkMatrix.m[absoluteIndex] = mValue;
	}
	
	return glkMatrix;
}

- (GLKMatrix3)glkMatrix3Value
{
	GLKMatrix3 glkMatrix;
	
	for (NSUInteger absoluteIndex = 0; absoluteIndex < (3 * 3); absoluteIndex++)
    {
		double mValue;
		if (absoluteIndex < self.count)
        {
			mValue = [self[absoluteIndex] floatValue];
		}
        else
        {
			mValue = [self.defaultMember floatValue];
		}
		
		glkMatrix.m[absoluteIndex] = mValue;
	}
	
	return glkMatrix;
}

- (GLKMatrix4)glkMatrix4Value
{
	GLKMatrix4 glkMatrix;
	
	for (NSUInteger absoluteIndex = 0; absoluteIndex < (4 * 4); absoluteIndex++)
    {
		double mValue;
		if (absoluteIndex < self.count)
        {
			mValue = [self[absoluteIndex] floatValue];
		}
        else
        {
			mValue = [self.defaultMember floatValue];
		}
		
		glkMatrix.m[absoluteIndex] = mValue;
	}
	
	return glkMatrix;
}

@end
