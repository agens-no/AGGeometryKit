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
@property (nonatomic, assign) NSUInteger columnCount;
@property (nonatomic, assign) NSUInteger rowCount;

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

- (void)testMatrixColumnCount
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:4 rows:3 members:members];
    
    XCTAssertEqual(matrix.columnCount, 4, @"Column count should be 4 regardless of how many members have been specified.");
}

- (void)testMatrixRowCount
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    XCTAssertEqual(matrix.rowCount, 4, @"Row count should be 4 regardless of how many members have been specified.");
}

- (void)testMatrixTotalCount
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @4, @3, @2, @1]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    XCTAssertEqual(matrix.count, (3 * 4), @"Count should be columns times rows, or 12 in the case of a 3x4 matrix.");
    
    matrix.columnCount += 1;
    XCTAssertEqual(matrix.count, (4 * 4), @"Count should return the total number of spots in the matrix based on the specified row and column dimensions.");
}

- (void)testObjectAtColumnIndexRowIndex
{
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    NSNumber *member = [matrix objectAtColumnIndex:1 rowIndex:1];
    XCTAssertEqualObjects(member, @6, @"Column/Row indexes are not returning the correct member");
}

- (void)testColumns {
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    NSArray *columns = matrix.columns;
    NSArray *comparisonArray = @[@[@1, @2, @3, @4], @[@5, @6, @7, @8], @[@0, @0, @0, @0]];
    
    XCTAssertEqual(columns.count, comparisonArray.count, @"Columns method is not returning the correct number of column arrays.");
    for (NSUInteger index = 0; index < columns.count; index++) {
        XCTAssert([(NSArray *)columns[index] isEqualToArray:comparisonArray[index]], @"Returned column at index %d should be: %@", index, comparisonArray[index]);
    }
}

- (void)testRows {
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    NSArray *rows = matrix.rows;
    NSArray *comparisonArray = @[@[@1, @5, @0], @[@2, @6, @0], @[@3, @7, @0], @[@4, @8, @0]];
    
    XCTAssertEqual(rows.count, comparisonArray.count, @"Rows method is not returning the correct number of row arrays.");
    for (NSUInteger index = 0; index < rows.count; index++) {
        XCTAssert([(NSArray *)rows[index] isEqualToArray:comparisonArray[index]], @"Returned row at index %d should be: %@", index, comparisonArray[index]);
    }
}

- (void)testColumnAtIndex {
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    NSArray *comparisonColumn = @[@5, @6, @7, @8];
    NSArray *column = [matrix columnAtIndex:1];
    XCTAssert([column isEqualToArray:comparisonColumn], @"Column 1 should be %@", comparisonColumn);
}

- (void)testRowAtIndex {
    NSMutableArray *members = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:members];
    
    NSArray *comparisonColumn = @[@2, @6, @0];
    NSArray *column = [matrix rowAtIndex:1];
    XCTAssert([column isEqualToArray:comparisonColumn], @"Row 1 should be %@", comparisonColumn);
}

@end
