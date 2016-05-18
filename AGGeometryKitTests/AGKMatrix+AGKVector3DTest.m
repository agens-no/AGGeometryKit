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
#import <AGGeometryKit/AGKMatrix+AGKVector3D.h>

@interface AGKMatrix_AGKVector3DTest : XCTestCase
@property (nonatomic, strong) NSArray *initialMembers;
@property (nonatomic, strong) AGKMatrix *matrix;
@end

@implementation AGKMatrix_AGKVector3DTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.initialMembers = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    self.matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:self.initialMembers];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMatrixWithVector3D
{
    AGKMatrix *vectorMatrix = [AGKMatrix matrixWithVector3D:AGKVector3DMake(2.0, 10.0, -1.0)];
    NSArray *columnComparison = @[@[@2.0, @10.0, @(-1.0)]];
    XCTAssertEqualObjects([vectorMatrix columns], columnComparison, @"Vector matrix should be a 1x3 matrix with the following column members: %@", columnComparison);
}

- (void)testMatrixByMultiplyingWithVector3D
{
    AGKMatrix *matrix = [self.matrix matrixByMultiplyingWithVector3D:AGKVector3DMake(2.0, 10.0, -1.0)];
    NSArray *comparisonColumns = @[@[@52.0, @64.0, @76.0, @88.0]];
    XCTAssertEqualObjects([matrix columns], comparisonColumns, @"The vector multiplied matrix should be a 1x3 matrix with the following columns: %@", comparisonColumns);
}

@end
