//
//  AGKMatrix+AGKVector3DTest.m
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/20/14.
//  Copyright (c) 2014 H√•vard Fossli. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGKMatrix+AGKVector3D.h"

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


- (void)testMatrixByMultiplyingWithVector3D {
    AGKMatrix *matrix = [self.matrix matrixByMultiplyingWithVector3D:AGKVector3DMake(2.0, 10.0, -1.0)];
    NSArray *comparisonColumns = @[@[@52.0, @64.0, @76.0, @88.0]];
    XCTAssertEqualObjects([matrix columns], comparisonColumns, @"The vector multiplied matrix should be a 1x3 matrix with the following columns: %@", comparisonColumns);
}

@end
