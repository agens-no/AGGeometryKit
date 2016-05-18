//
// Authors:
// Logan Holmes @snown
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

#import <XCTest/XCTest.h>
#import <QuartzCore/QuartzCore.h>
#import <AGGeometryKit/AGKMatrix+CATransform3D.h>

@interface AGKMatrix_CATransform3DTest : XCTestCase

@property (nonatomic, assign) CATransform3D transform;

@end

NSString *NSStringFromCATransform3D(CATransform3D transform)
{
	NSMutableString *output = [NSMutableString stringWithFormat:@"<CATransform3D>[\n"];
	[output appendFormat:@"%f, %f, %f, %f\n", transform.m11, transform.m21, transform.m31, transform.m41];
	[output appendFormat:@"%f, %f, %f, %f\n", transform.m12, transform.m22, transform.m32, transform.m42];
	[output appendFormat:@"%f, %f, %f, %f\n", transform.m13, transform.m23, transform.m33, transform.m43];
	[output appendFormat:@"%f, %f, %f, %f\n", transform.m14, transform.m24, transform.m34, transform.m44];
	[output appendString:@"]"];
	
	return output;
}


@implementation AGKMatrix_CATransform3DTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    CATransform3D transform = CATransform3DIdentity;
    transform.m11 = 11.0;
    transform.m12 = 12.0;
    transform.m13 = 13.0;
    transform.m14 = 14.0;
    transform.m21 = 21.0;
    transform.m22 = 22.0;
    transform.m23 = 23.0;
    transform.m24 = 24.0;
    transform.m31 = 31.0;
    transform.m32 = 32.0;
    transform.m33 = 33.0;
    transform.m34 = 34.0;
    transform.m41 = 41.0;
    transform.m42 = 42.0;
    transform.m43 = 43.0;
    transform.m44 = 44.0;
    
    self.transform = transform;

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (AGKMatrix *)generateMatrixWithColumns:(NSUInteger)columnCount rows:(NSUInteger)rowCount
{
    NSMutableArray *members = [NSMutableArray array];
    for (NSUInteger columnIndex = 0; columnIndex < columnCount; columnIndex++)
    {
        NSUInteger columnIdentifier = (columnIndex + 1) * 10;
        for (NSUInteger rowIndex = 0; rowIndex < rowCount; rowIndex++)
        {
            members[(columnIndex * rowCount) + rowIndex] = @(columnIdentifier + (rowIndex + 1));
        }
    }
    
    return [[AGKMatrix alloc] initWithColumns:columnCount rows:rowCount members:members];
}

- (void)testMatrixWithCATransform3D
{
    AGKMatrix *matrix = [AGKMatrix matrixWithCATransform3D:self.transform];
    NSArray *comparisonColumns = @[
                                   @[@11, @12, @13, @14],
                                   @[@21, @22, @23, @24],
                                   @[@31, @32, @33, @34],
                                   @[@41, @42, @43, @44],
                                   ];
    
    XCTAssertEqualObjects(matrix.columns, comparisonColumns, @"AGKMatrix created with the test CATransform should result in these columns: %@", comparisonColumns);
}

- (void)test4x4MatrixCATransform3DValue
{
    AGKMatrix *matrix = [self generateMatrixWithColumns:4 rows:4];
    XCTAssertTrue(CATransform3DEqualToTransform(self.transform, [matrix caTransform3DValue]), @"A 4x4 AGKMatrix should just fill it's members into a CATransform3D");
}

- (void)test3x3MatrixCATransform3DValue
{
    AGKMatrix *matrix = [self generateMatrixWithColumns:3 rows:3];
    
    CATransform3D transform = self.transform;
    transform.m13 = 0.0;
    transform.m14 = 13.0;
    transform.m23 = 0.0;
    transform.m24 = 23.0;
    transform.m31 = 0.0;
    transform.m32 = 0.0;
    transform.m33 = 1.0;
    transform.m34 = 0.0;
    transform.m41 = 31.0;
    transform.m42 = 32.0;
    transform.m43 = 0.0;
    transform.m44 = 33.0;
    
    CATransform3D testTransform = [matrix caTransform3DValue];
    XCTAssertTrue(CATransform3DEqualToTransform(transform, testTransform), @"A 3x3 AGKMatrix should insert a 3rd column and 3rd row filled with 0s, other than index 3 for both. Instead we got: %@", NSStringFromCATransform3D(testTransform));
}

- (void)test4x3MatrixCATransform3DValue
{
    AGKMatrix *matrix = [self generateMatrixWithColumns:4 rows:3];
    
    CATransform3D transform = self.transform;
    transform.m13 = 0.0;
    transform.m14 = 13.0;
    transform.m23 = 0.0;
    transform.m24 = 23.0;
    transform.m33 = 1.0;
    transform.m34 = 33.0;
    transform.m43 = 0.0;
    transform.m44 = 43.0;
    
    CATransform3D testTransform = [matrix caTransform3DValue];
    XCTAssertTrue(CATransform3DEqualToTransform(transform, testTransform), @"A 4x3 AGKMatrix should insert a 3rd row filled with 0s, except index 3 should be a 1. Instead we got: %@", NSStringFromCATransform3D(testTransform));
}

- (void)test3x4MatrixCATransform3DValue
{
    AGKMatrix *matrix = [self generateMatrixWithColumns:3 rows:4];
    
    CATransform3D transform = self.transform;
    transform.m11 = 11.0;
    transform.m12 = 12.0;
    transform.m13 = 13.0;
    transform.m14 = 14.0;
    transform.m21 = 21.0;
    transform.m22 = 22.0;
    transform.m23 = 23.0;
    transform.m24 = 24.0;
    transform.m31 = 0.0;
    transform.m32 = 0.0;
    transform.m33 = 1.0;
    transform.m34 = 0.0;
    transform.m41 = 31.0;
    transform.m42 = 32.0;
    transform.m43 = 33.0;
    transform.m44 = 34.0;
    
    CATransform3D testTransform = [matrix caTransform3DValue];
    XCTAssertTrue(CATransform3DEqualToTransform(transform, testTransform), @"A 3x4 AGKMatrix should insert a 3rd column filled with 0s, except index 3 should be a 1. Instead we got: %@", NSStringFromCATransform3D(testTransform));
}

@end
