//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIImage+AGKQuad.h"
#import "pthread.h"
#import <QuartzCore/QuartzCore.h>
#import "CGImageRef+AGK+CATransform3D.h"
#import "UIImage+AGK+CATransform3D.h"
#import "AGKMatrix.h"
#import "AGKMatrix+CATransform3D.h"

@implementation UIImage (AGKQuad)

- (UIImage *)imageWithQuad:(AGKQuad)quad scale:(CGFloat)scale
{
    AGKQuad scaledQuad = AGKQuadApplyCATransform3D(quad, CATransform3DMakeScale(scale, scale, 1.0));
    CATransform3D transform = CATransform3DWithAGKQuadFromBounds(scaledQuad, (CGRect){CGPointZero, self.size});
    CGImageRef imageRef = CGImageDrawWithCATransform3D_AGK(self.CGImage, transform, CGPointZero, self.size, 1.0);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

- (UIImage *)imageByCroppingToRect:(CGRect)cropRect {
    CGImageRef croppedImage = CGImageCreateWithImageInRect([self CGImage], cropRect);
    return [UIImage imageWithCGImage:croppedImage scale:self.scale orientation:self.imageOrientation];
}

- (UIImage *)imageWithPerspectiveCorrectionFromQuad:(AGKQuad)quad
{
    AGKQuad destinationQuad = AGKQuadMakeWithCGRect(CGRectMake(0.0, 0.0, 600.0, 600.0));
//    AGKQuad destinationQuad = AGKQuadMakeWithCGSize(self.size);
    CATransform3D transform = [self generatePerspectiveTransformMatrixFromQuad:quad toQuad:destinationQuad];
    
    UIImage *correctedImage = [self imageWithTransform:transform anchorPoint:CGPointZero];
    UIImage *resultImage = [correctedImage imageByCroppingToRect:CGRectMake(0.0, 0.0, 600.0, 600.0)];
    
    return resultImage;
}

- (CATransform3D)generatePerspectiveTransformMatrixFromQuad:(AGKQuad)sourceQuad toQuad:(AGKQuad)destinationQuad
{
    // Calculate the two required matrices
    AGKMatrix *firstMatrix = [AGKMatrix matrixWithColumns:8 rows:8];
    AGKMatrix *secondMatrix = [AGKMatrix matrixWithColumns:1 rows:8];
    
    for (NSInteger i = 0; i < 4; i++) {
		[firstMatrix setObject:@(sourceQuad.v[i].x) atColumnIndex:0 rowIndex:i];
		[firstMatrix setObject:@(sourceQuad.v[i].y) atColumnIndex:1 rowIndex:i];
		[firstMatrix setObject:@1.0 atColumnIndex:2 rowIndex:i];
		[firstMatrix setObject:@(sourceQuad.v[i].x) atColumnIndex:3 rowIndex:i + 4];
		[firstMatrix setObject:@(sourceQuad.v[i].y) atColumnIndex:4 rowIndex:i + 4];
		[firstMatrix setObject:@1.0 atColumnIndex:5 rowIndex:i + 4];
		
		[firstMatrix setObject:@0.0 atColumnIndex:3 rowIndex:i];
		[firstMatrix setObject:@0.0 atColumnIndex:4 rowIndex:i];
		[firstMatrix setObject:@0.0 atColumnIndex:5 rowIndex:i];
		[firstMatrix setObject:@0.0 atColumnIndex:0 rowIndex:i + 4];
		[firstMatrix setObject:@0.0 atColumnIndex:1 rowIndex:i + 4];
		[firstMatrix setObject:@0.0 atColumnIndex:2 rowIndex:i + 4];
		
		[firstMatrix setObject:@(-sourceQuad.v[i].x * destinationQuad.v[i].x) atColumnIndex:6 rowIndex:i];
		[firstMatrix setObject:@(-sourceQuad.v[i].y * destinationQuad.v[i].x) atColumnIndex:7 rowIndex:i];
		[firstMatrix setObject:@(-sourceQuad.v[i].x * destinationQuad.v[i].y) atColumnIndex:6 rowIndex:i + 4];
		[firstMatrix setObject:@(-sourceQuad.v[i].y * destinationQuad.v[i].y) atColumnIndex:7 rowIndex:i + 4];
		
		[secondMatrix setObject:@(destinationQuad.v[i].x) atColumnIndex:0 rowIndex:i];
		[secondMatrix setObject:@(destinationQuad.v[i].y) atColumnIndex:0 rowIndex:i + 4];
	}
    
    // Solve for the two matrices
    AGKMatrix *matrixA = [AGKMatrix matrixWithMatrix:firstMatrix];
    [matrixA transpose];
    NSUInteger rowCount = matrixA.rowCount;
    AGKMatrix *matrixV = [AGKMatrix matrixWithColumns:rowCount rows:rowCount];
	AGKMatrix *matrixW = [self jacobiSVDForMatrixA:matrixA matrixV:matrixV];
	AGKMatrix *matrixX = [self singleValueBackSubstitutionForColumns:matrixA.columnCount rows:rowCount wMatrix:matrixW uMatrix:matrixA vMatrix:matrixV bMatrix:secondMatrix];
    
    AGKMatrix *perspectiveMatrix = [matrixX matrixWithColumnSize:3 rowSize:3 andTranspose:YES];
    [perspectiveMatrix setObject:@1 atIndexedSubscript:(perspectiveMatrix.count - 1)];
    
    return [perspectiveMatrix caTransform3DValue];
}

- (AGKMatrix *)jacobiSVDForMatrixA:(inout AGKMatrix *)matrixA matrixV:(inout AGKMatrix *)matrixV {
	return [self jacobiSVDForMatrixA:matrixA matrixV:matrixV n:-1];
}

- (AGKMatrix *)jacobiSVDForMatrixA:(inout AGKMatrix *)matrixA matrixV:(inout AGKMatrix *)matrixV n:(NSInteger)n {
	NSInteger n1 = (matrixV == nil) ? 0 : (n < 0) ? matrixA.columnCount : n;
	return [self jacobiSVDForMatrixA:matrixA matrixV:matrixV withRows:matrixA.rowCount columns:matrixA.columnCount n:n1];
}

- (AGKMatrix *)jacobiSVDForMatrixA:(inout AGKMatrix *)matrixA matrixV:(inout AGKMatrix *)matrixV withRows:(NSUInteger)matRows columns:(NSUInteger)matCols n:(NSInteger)n1 {
    NSAssert(matrixA != nil, @"Method must include at least MatrixA");
	if (!matrixA) {
		return nil;
	}
    
    // TODO: convert double references to CGFloat for cocoa-ification
	double minval = DBL_MIN;
	double epsilon = DBL_EPSILON * 10;
    
    // Calculate Matrix W
    AGKMatrix *matrixW = [[AGKMatrix alloc] init];
	[matrixA enumerateRowsUsingBlock:^(NSArray *row, NSUInteger rowIndex, BOOL *stop) {
		double combinedRow = 0;
		for (NSNumber *rowItem in row) {
			combinedRow += [rowItem doubleValue] * [rowItem doubleValue];
		}
		
		[matrixW setObject:@(combinedRow) atColumnIndex:0 rowIndex:rowIndex];
		
		if (matrixV) {
			[matrixV fillRow:rowIndex withObject:@0];
			[matrixV setObject:@1 atColumnIndex:rowIndex rowIndex:rowIndex];
		}
	}];
    
    // Calculate appropriate cosine and sine values, and perform Givens Rotation
    double cosine, sine;
	NSUInteger max_iter = MAX(matCols, 30);
	
	for (NSUInteger iter = 0; iter < max_iter; iter++) {
		BOOL changed = NO;
		
		for (int firstIndex = 0; firstIndex < matRows - 1; firstIndex++) {
			for (int secondIndex = firstIndex + 1; secondIndex < matRows; secondIndex++) {
				double wA = [[matrixW objectAtColumnIndex:0 rowIndex:firstIndex] doubleValue];
				double wB = [[matrixW objectAtColumnIndex:0 rowIndex:secondIndex] doubleValue];
				double p = 0.0;
				
				for (int valueIndex = 0; valueIndex < matCols; valueIndex++) {
					p += [[matrixA objectAtColumnIndex:valueIndex rowIndex:firstIndex] doubleValue] * [[matrixA objectAtColumnIndex:valueIndex rowIndex:secondIndex] doubleValue];
				}
				
				if (ABS(p) <= epsilon * sqrt(wA * wB)) {
					continue;
				}
				
				p *= 2.0;
				double beta = wA - wB;
				double gamma = hypot(p, beta);
				if (beta < 0) {
					double delta = (gamma - beta) * 0.5;
					sine = (double)sqrt(delta / gamma);
					cosine = (double)(p/(gamma * sine * 2.0));
				} else {
					cosine = (double)sqrt((gamma + beta) / (gamma * 2.0));
					sine = (double)(p/(gamma * cosine * 2.0));
				}
				
				wA = 0.0;
				wB = 0.0;
				for (int valueIndex = 0; valueIndex < matCols; valueIndex++) {
					double firstValue = [[matrixA objectAtColumnIndex:valueIndex rowIndex:firstIndex] doubleValue];
					double secondValue = [[matrixA objectAtColumnIndex:valueIndex rowIndex:secondIndex] doubleValue];
					double t0 = cosine * firstValue + sine * secondValue;
					double t1 = -sine * firstValue + cosine * secondValue;
					
					[matrixA setObject:@(t0) atColumnIndex:valueIndex rowIndex:firstIndex];
					[matrixA setObject:@(t1) atColumnIndex:valueIndex rowIndex:secondIndex];
					wA += (double)t0*t0;
					wB += (double)t1*t1;
				}
				[matrixW setObject:@(wA) atColumnIndex:0 rowIndex:firstIndex];
				[matrixW setObject:@(wB) atColumnIndex:0 rowIndex:secondIndex];
				
				changed = YES;
				
				if (matrixV) {
					[matrixV performGivensRotationOnRow:firstIndex andRow:secondIndex withCosine:@(cosine) sine:@(sine)];
				}
			}
		}
		
		if (!changed) {
			break;
		}
	}
    
    // Update Matrix W member values
    for (NSUInteger rowIndex = 0; rowIndex < matrixA.rowCount; rowIndex++) {
		double combinedValue = 0;
		for (NSUInteger colIndex = 0; colIndex < matrixA.columnCount; colIndex++) {
			double value = [[matrixA objectAtColumnIndex:colIndex rowIndex:rowIndex] doubleValue];
			combinedValue += value*value;
		}
		[matrixW setObject:@(sqrt(combinedValue)) atColumnIndex:0 rowIndex:rowIndex];
	}
    
    //  Sort members of Matrix w and Matrix V
    for (NSUInteger row1Index = 0; row1Index < matRows - 1; row1Index++) {
		for (NSUInteger row2Index = row1Index + 1; row2Index < matRows; row2Index++) {
			NSNumber *row1Number = [matrixW objectAtColumnIndex:0 rowIndex:row1Index];
			NSNumber *row2Number = [matrixW objectAtColumnIndex:0 rowIndex:row2Index];
			if ([row1Number compare:row2Number] == NSOrderedAscending) {
				[matrixW setObject:row2Number atColumnIndex:0 rowIndex:row1Index];
				[matrixW setObject:row1Number atColumnIndex:0 rowIndex:row2Index];
				
				if (matrixV) {
					for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
						[matrixA exchangeMemberAtColumn:colIndex row:row1Index withColumn:colIndex row:row2Index];
						[matrixV exchangeMemberAtColumn:colIndex row:row1Index withColumn:colIndex row:row2Index];
					}
				}
			}
		}
	}
    
    // Factor in Matrix V if exists
    if (matrixV) {
		for (NSUInteger index = 0; index < n1; index++) {
			double testValue = index < matRows ? [[matrixW objectAtColumnIndex:0 rowIndex:index] doubleValue] : 0.0;
			while (testValue <= minval) {
				// if we got a zero singular value, then in order to get the corresponding left singular vector
				// we generate a random vector, project it to the previously computed left singular vectors,
				// subtract the projection and normalize the difference.
				const double valueSeed = 1.0 / matCols;
				for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
					double value = arc4random_uniform(256.0) != 0 ? valueSeed : -valueSeed;
					[matrixA setObject:@(value) atColumnIndex:colIndex rowIndex:index];
				}
				
				for (NSUInteger iterationCount = 0; iterationCount < 2; iterationCount++) {
					for (NSUInteger secondIndex = 0; secondIndex < index; secondIndex++) {
						double combinedValue1 = 0;
						for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
							combinedValue1 += ([[matrixA objectAtColumnIndex:colIndex rowIndex:index] doubleValue] * [[matrixA objectAtColumnIndex:colIndex rowIndex:secondIndex] doubleValue]);
						}
						
						double combinedValue2 = 0;
						for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
							double calcValue = [[matrixA objectAtColumnIndex:colIndex rowIndex:index] doubleValue] - (combinedValue1 * [[matrixA objectAtColumnIndex:colIndex rowIndex:secondIndex] doubleValue]);
							[matrixA setObject:@(calcValue) atColumnIndex:colIndex rowIndex:index];
							
							combinedValue2 += ABS(calcValue);
						}
						
						combinedValue2 = combinedValue2 != 0 ? 1.0 / combinedValue2 : 0.0;
						for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
							double currentValue = [[matrixA objectAtColumnIndex:colIndex rowIndex:index] doubleValue];
							[matrixA setObject:@(currentValue * combinedValue2) atColumnIndex:colIndex rowIndex:index];
						}
					}
				}
				
				testValue = 0;
				for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
					double value = [[matrixA objectAtColumnIndex:colIndex rowIndex:index] doubleValue];
					testValue += value * value;
				}
				testValue = sqrt(testValue);
			}
			
			double value = (1.0 / testValue);
			for (NSUInteger colIndex = 0; colIndex < matCols; colIndex++) {
				double currentValue = [[matrixA objectAtColumnIndex:colIndex rowIndex:index] doubleValue];
				[matrixA setObject:@(currentValue * value) atColumnIndex:colIndex rowIndex:index];
			}
		}
	}
    
    return matrixW;
}

- (AGKMatrix *)singleValueBackSubstitutionForColumns:(NSUInteger)sourceCols rows:(NSUInteger)sourceRows wMatrix:(AGKMatrix *)wMatrix uMatrix:(AGKMatrix *)uMatrix vMatrix:(AGKMatrix *)vMatrix bMatrix:(AGKMatrix *)bMatrix
{
    double threshold = 0;
	NSUInteger smallestDimension = MIN(sourceCols, sourceRows);
	double epsilon = DBL_EPSILON * 2.0;
	NSUInteger bCols;
    if( bMatrix ) {
		bCols = bMatrix.columnCount;
	} else {
        bCols = sourceCols;
	}
	
	AGKMatrix *xMatrix = [AGKMatrix matrixWithColumns:bCols rows:sourceRows];
    xMatrix.defaultMember = @0;
	
    // Calculate threshold
    for( NSUInteger rowIndex = 0; rowIndex < smallestDimension; rowIndex++ ) {
		threshold += [[wMatrix objectAtColumnIndex:0 rowIndex:rowIndex] doubleValue];
	}
    threshold *= epsilon;
	
	// Apply threshold to Matrix X
	for (NSUInteger rowIndex = 0; rowIndex < smallestDimension; rowIndex++) {
		double wValue = [[wMatrix objectAtColumnIndex:0 rowIndex:rowIndex] doubleValue];
		if (ABS(wValue) <= threshold) {
			continue;
		}
		wValue = 1.0 / wValue;
		
		if (bCols == 1) {
			double combinedValue = 0;
			if (bMatrix) {
				for(NSUInteger colIndex = 0; colIndex < sourceCols; colIndex++) {
					combinedValue += [[uMatrix objectAtColumnIndex:colIndex rowIndex:rowIndex] doubleValue] * [[bMatrix objectAtColumnIndex:0 rowIndex:colIndex] doubleValue];
				}
			} else {
				combinedValue = [[uMatrix objectAtColumnIndex:0 rowIndex:0] doubleValue];
			}
			combinedValue *= wValue;
			
			for (NSUInteger colIndex = 0; colIndex < sourceRows; colIndex++) {
				double loopValue = [[xMatrix objectAtColumnIndex:0 rowIndex:colIndex] doubleValue] + (combinedValue * [[vMatrix objectAtColumnIndex:colIndex rowIndex:rowIndex] doubleValue]);
				[xMatrix setObject:@(loopValue) atColumnIndex:0 rowIndex:colIndex];
			}
		} else {
			AGKMatrix *bufferMatrix = [AGKMatrix matrix];
			if (bMatrix) {
				for (NSUInteger colIndex = 0; colIndex < bCols; colIndex++) {
					[bufferMatrix setObject:@0 atColumnIndex:colIndex rowIndex:0];
				}
				
				[self matrixAXPYForRows:sourceCols columns:bCols matrixA:bMatrix matrixX:uMatrix matrixY:bufferMatrix];
				
				for (NSUInteger colIndex = 0; colIndex < bCols; colIndex++) {
					double bufValue = [[bufferMatrix objectAtColumnIndex:colIndex rowIndex:0] doubleValue];
					[bufferMatrix setObject:@(bufValue * wValue) atColumnIndex:colIndex rowIndex:0];
				}
			} else {
				for( NSUInteger colIndex = 0; colIndex < bCols; colIndex++ ) {
					double newValue = [[uMatrix objectAtColumnIndex:colIndex rowIndex:rowIndex] doubleValue] * wValue;
					[bufferMatrix setObject:@(newValue) atColumnIndex:colIndex rowIndex:0];
				}
			}
			
			[self matrixAXPYForRows:sourceCols columns:bCols matrixA:bufferMatrix matrixX:vMatrix matrixY:xMatrix];
		}
	}
	
	return xMatrix;
}

// This method is mostly untested. It has been included for the cases where the
// `singleValueBackSubstitution` method has a b column count greater than one,
// but this does not occur with perspective correction (our curent use case) and
// therefore I have not been able to test it thoroughly. I've included it here
// for completeness.
/* y[0:m,0:n] += diag(a[0:1,0:m]) * x[0:m,0:n] */
- (void)matrixAXPYForRows:(NSUInteger)rowCount columns:(NSUInteger)colCount matrixA:(AGKMatrix *)aMatrix matrixX:(AGKMatrix *)xMatrix matrixY:(inout AGKMatrix *)yMatrix
{
	NSUInteger yRowsCount = yMatrix.rowCount ?: 1;
	NSUInteger xRowsCount = xMatrix.rowCount ?: 1;
	
	for (NSUInteger rowIndex = 0; rowIndex < rowCount; rowIndex++) {
		double aValue = [[aMatrix objectAtColumnIndex:0 rowIndex:rowIndex] doubleValue];
		
		NSUInteger xColIndex = 0;
		NSUInteger yColIndex = 0;
		for (NSUInteger columnIndex = 0; columnIndex < colCount; columnIndex++, xColIndex++, yColIndex++) {
			
			// Account for different Matrix dimensions
			NSUInteger xColWrap = (rowIndex / xRowsCount);
			if (xColWrap >= 1) {
				xColIndex += xColWrap;
			}
			NSUInteger yColWrap = (rowIndex / yRowsCount);
			if (yColWrap >= 1) {
				yColIndex += yColWrap;
			}
			
			// xMatrix should not change in this method
			// make sure we have enough xMatrix columns
			if (xColIndex < xMatrix.columnCount) {
				double yValue = [[yMatrix objectAtColumnIndex:yColIndex rowIndex:(rowIndex % yRowsCount)] doubleValue];
				double xValue = [[xMatrix objectAtColumnIndex:xColIndex rowIndex:(rowIndex % xRowsCount)] doubleValue];
				
				[yMatrix setObject:@(yValue + (aValue * xValue)) atColumnIndex:yColIndex rowIndex:(rowIndex % yRowsCount)];
			}
		}
	}
}



@end
