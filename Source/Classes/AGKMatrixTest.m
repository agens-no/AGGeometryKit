//
//  AGKMatrixTest.m
//  AGGeometryKit
//
//  Created by Logan Holmes on 7/15/14.
//  Copyright (c) 2014 Håvard Fossli. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGKMatrix.h"

@interface AGKMatrixTest : XCTestCase
@end

@interface AGKMatrix ()
@property (nonatomic, strong) NSMutableArray *members;
@end

@implementation AGKMatrixTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDesignatedInitializer
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @4, @3, @2, @1]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    XCTAssertEqual(matrix.columnCount, 3, @"Resulting matrix does not have the right number of columns");
    XCTAssertEqual(matrix.rowCount, 4, @"Resulting matrix does not have the right number of rows");
    XCTAssertEqualObjects(matrix.members, members, @"Resulting matrix does not contain the passed in members plus default numbers");
}

- (void)testInit
{
    AGKMatrix *matrix = [[AGKMatrix alloc] init];
    
    XCTAssertEqual(matrix.columnCount, 0, @"Resulting matrix does not have the right number of columns");
    XCTAssertEqual(matrix.rowCount, 0, @"Resulting matrix does not have the right number of rows");
    XCTAssertEqualObjects(matrix.members, @[], @"Resulting matrix does not return an empty array as expected");
}

- (void)testFactoryMethodMatrix
{
    AGKMatrix *matrix = [AGKMatrix matrix];
    
    XCTAssertEqual(matrix.columnCount, 0, @"Resulting matrix does not have the right number of columns");
    XCTAssertEqual(matrix.rowCount, 0, @"Resulting matrix does not have the right number of rows");
    XCTAssertEqualObjects(matrix.members, @[], @"Resulting matrix does not return an empty array as expected");
}

- (void)testMatrixCompareIsEqual
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @4, @3, @2, @1]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    AGKMatrix *sameMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @2, @3, @4, @4, @3, @2, @1]];
    AGKMatrix *sameMatrixAgain = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @2, @3, @4, @4, @3, @2, @1, @0, @0, @0, @0]];
    AGKMatrix *differentMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1]];
    
    XCTAssertEqualObjects(matrix, sameMatrix, @"Matrices should be equal");
    XCTAssertEqualObjects(matrix, sameMatrixAgain, @"Matrices should be equal");
    XCTAssertNotEqualObjects(matrix, differentMatrix, @"Matrices should not be equal");
    
}

@end
