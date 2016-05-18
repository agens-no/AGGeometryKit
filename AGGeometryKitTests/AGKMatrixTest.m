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
#import <AGGeometryKit/AGKMatrix.h>

@interface AGKMatrixTest : XCTestCase
@property (nonatomic, strong) AGKMatrix *testMatrix;
@property (nonatomic, strong) NSArray *initialMembers;
@end

@interface AGKMatrix ()
@property (nonatomic, assign) NSUInteger columnCount;
@property (nonatomic, assign) NSUInteger rowCount;

@property (nonatomic, strong) NSMutableArray *members;
- (NSArray *)allMembers;
@end

@implementation AGKMatrixTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.initialMembers = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    self.testMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:self.initialMembers];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDesignatedInitializer
{
    XCTAssertEqual(self.testMatrix.columnCount, 3, @"Resulting matrix does not have the right number of columns");
    XCTAssertEqual(self.testMatrix.rowCount, 4, @"Resulting matrix does not have the right number of rows");
    NSArray *comparisonArray = [self.initialMembers arrayByAddingObjectsFromArray:@[@0, @0, @0, @0]];
    XCTAssertEqualObjects([self.testMatrix allMembers], comparisonArray, @"Resulting matrix does not contain the passed in members plus default numbers");
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

- (void)testDefaultMember {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:nil];
    
    XCTAssertEqualObjects(matrix.defaultMember, @0, @"Matrix should default to 0 by default");
    XCTAssertEqualObjects(matrix.members, @[], @"No members should have been set yet");
    XCTAssertEqualObjects([matrix objectAtColumnIndex:0 rowIndex:0], @0, @"Matrix should return the default value for any valid unfilled member position");
    
    matrix.defaultMember = @1;
    XCTAssertEqualObjects([matrix objectAtColumnIndex:0 rowIndex:0], @1, @"Matrix should substitute in the new defaultMember @1 for any valid unfilled member position");
}

- (void)testMatrixCompareIsEqual
{
    AGKMatrix *sameMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    AGKMatrix *sameMatrixAgain = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @2, @3, @4, @5, @6, @7, @8, @0, @0, @0, @0]];
    AGKMatrix *differentMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:4 members:@[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1]];
    
    XCTAssertEqualObjects(self.testMatrix, sameMatrix, @"Matrices should be equal");
    XCTAssertEqualObjects(self.testMatrix, sameMatrixAgain, @"Matrices should be equal");
    XCTAssertNotEqualObjects(self.testMatrix, differentMatrix, @"Matrices should not be equal");
    
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
    XCTAssertEqual(self.testMatrix.count, (3 * 4), @"Count should be columns times rows, or 12 in the case of a 3x4 matrix.");
    
    self.testMatrix.columnCount += 1;
    XCTAssertEqual(self.testMatrix.count, (4 * 4), @"Count should return the total number of spots in the matrix based on the specified row and column dimensions.");
}

#pragma mark - Accessing Members, Columns and Rows

- (void)testObjectAtColumnIndexRowIndex
{
    NSNumber *member = [self.testMatrix objectAtColumnIndex:1 rowIndex:1];
    XCTAssertEqualObjects(member, @6, @"Column/Row indexes are not returning the correct member");
}

- (void)testColumns {
    NSArray *columns = self.testMatrix.columns;
    NSArray *comparisonArray = @[@[@1, @2, @3, @4], @[@5, @6, @7, @8], @[@0, @0, @0, @0]];
    
    XCTAssertEqual(columns.count, comparisonArray.count, @"Columns method is not returning the correct number of column arrays.");
    for (NSUInteger index = 0; index < columns.count; index++) {
        XCTAssert([(NSArray *)columns[index] isEqualToArray:comparisonArray[index]], @"Returned column at index %lu should be: %@", (unsigned long)index, comparisonArray[index]);
    }
}

- (void)testRows {
    NSArray *rows = self.testMatrix.rows;
    NSArray *comparisonArray = @[@[@1, @5, @0], @[@2, @6, @0], @[@3, @7, @0], @[@4, @8, @0]];
    
    XCTAssertEqual(rows.count, comparisonArray.count, @"Rows method is not returning the correct number of row arrays.");
    for (NSUInteger index = 0; index < rows.count; index++) {
        XCTAssert([(NSArray *)rows[index] isEqualToArray:comparisonArray[index]], @"Returned row at index %lu should be: %@", (unsigned long)index, comparisonArray[index]);
    }
}

- (void)testColumnAtIndex {
    NSArray *comparisonColumn = @[@5, @6, @7, @8];
    NSArray *column = [self.testMatrix columnAtIndex:1];
    XCTAssert([column isEqualToArray:comparisonColumn], @"Column 1 should be %@", comparisonColumn);
}

- (void)testRowAtIndex {
    NSArray *comparisonColumn = @[@2, @6, @0];
    NSArray *column = [self.testMatrix rowAtIndex:1];
    XCTAssert([column isEqualToArray:comparisonColumn], @"Row 1 should be %@", comparisonColumn);
}

- (void)testObjectAtIndexedSubscript {
    XCTAssertEqualObjects(self.testMatrix[2], @3, @"Subscripting should access the matrix as an index list of column first members.");
    XCTAssertEqualObjects(self.testMatrix[8], self.testMatrix.defaultMember, @"Subscripting should return the default value if no other value has been specified.");
}

- (void)testEnumerateMembersUsingBlock {
    __block NSUInteger defaultValuesRecieved = 0;
    [self.testMatrix enumerateMembersUsingBlock:^(NSNumber *member, NSUInteger index, NSUInteger columnIndex, NSUInteger rowIndex, BOOL *stop) {
        XCTAssertEqual(columnIndex, index / 4, @"Column index should be %lu for absolute index %lu on a 3x4 matrix", index / 4, (unsigned long)index);
        XCTAssertEqual(rowIndex, index % 4, @"Row index should be %lu for absolute index %lu on a 3x4 matrix", index % 4, (unsigned long)index);
        
        if (index < self.initialMembers.count) {
            XCTAssertEqualObjects(member, self.initialMembers[index], @"The returned member should be the same as the one passed in: %@", self.initialMembers[index]);
        } else {
            defaultValuesRecieved++;
            if (defaultValuesRecieved < 3) {
                XCTAssertEqualObjects(member, self.testMatrix.defaultMember, @"Member at index %lu has not been assigned yet, and therefore should return the default member: %@", (unsigned long)index, self.testMatrix.defaultMember);
                if (defaultValuesRecieved > 1) {
                    *stop = YES;
                }
            } else {
                XCTAssertEqual(*stop, YES, @"The stop argument should have been set to YES");
                XCTFail(@"The stop argument has been set to YES, and should have stopped execution of the block");
            }
        }
    }];
}

- (void)testEnumerateColumnsUsingBlock {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:4 rows:4 members:self.initialMembers];
    
    NSArray *comparisonArray = @[@[@1, @2, @3, @4], @[@5, @6, @7, @8], @[@0, @0, @0, @0], @[@0, @0, @0, @0], @[@0, @0, @0, @0]];
    [matrix enumerateColumnsUsingBlock:^(NSArray *column, NSUInteger columnIndex, BOOL *stop) {
        if (columnIndex < 2) {
            XCTAssertEqualObjects(column, comparisonArray[columnIndex], @"Column %lu should be the same as comparisonArray[%lu]: %@", (unsigned long)columnIndex, (unsigned long)columnIndex, comparisonArray[columnIndex]);
        } else if (columnIndex < 4) {
            NSNumber *defaultMember = matrix.defaultMember;
            NSArray *defaultArray = @[defaultMember, defaultMember, defaultMember, defaultMember];
            XCTAssertEqualObjects(column, defaultArray, @"Column %lu should generate an array of default members equal to the number of rows: @%@ x 4", (unsigned long)columnIndex, defaultMember);
            
            if (columnIndex == 3) {
                *stop = YES;
            }
        } else {
            XCTAssertEqual(*stop, YES, @"The stop argument should have been set to YES");
            XCTFail(@"The stop argument has been set to YES, and should have stopped execution of the block");
        }
    }];
}

- (void)testEnumerateRowsUsingBlock {
    NSArray *comparisonArray = @[@[@1, @5, @0], @[@2, @6, @0], @[@3, @7, @0], @[@4, @8, @0]];
    [self.testMatrix enumerateRowsUsingBlock:^(NSArray *row, NSUInteger rowIndex, BOOL *stop) {
        if (rowIndex) {
            XCTAssertEqualObjects(row, comparisonArray[rowIndex], @"Row %lu should be the same as comparisonArray[%lu]: %@", (unsigned long)rowIndex, (unsigned long)rowIndex, comparisonArray[rowIndex]);
        }
    }];
}

#pragma mark - Adding Members, Columns and Rows

- (void)testSetObjectAtColumnIndexRowIndex {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:0 rows:0 members:nil];
    
    [matrix setObject:@11 atColumnIndex:0 rowIndex:0];
    XCTAssertEqualObjects([matrix objectAtColumnIndex:0 rowIndex:0], @11, @"Member at 0x0 should be 11");
    
    [matrix setObject:@31 atColumnIndex:2 rowIndex:0];
    XCTAssertEqualObjects([matrix objectAtColumnIndex:1 rowIndex:0], matrix.defaultMember, @"Member at unspecified location 1x0 should be the defaultMember: %@", matrix.defaultMember);
    XCTAssertEqualObjects([matrix objectAtColumnIndex:2 rowIndex:0], @31, @"Member at 2x0 should be 31");
    
    [matrix setObject:@34 atColumnIndex:2 rowIndex:3];
    XCTAssertEqualObjects([matrix objectAtColumnIndex:2 rowIndex:0], @31, @"Member at 2x0 should be 31 even after expanding the array");
    XCTAssertEqualObjects([matrix objectAtColumnIndex:0 rowIndex:3], @0, @"Member at unspecified location 0x3 should be the defaultMember: %@", matrix.defaultMember);
    XCTAssertEqualObjects([matrix objectAtColumnIndex:2 rowIndex:3], @34, @"Member at 2x3 should be 34 even after");
}

- (void)testSetColumnAtIndexWithArray {
    NSArray *fourthColumn = @[@9, @9, @9, @9];
    [self.testMatrix setColumnAtIndex:3 withArray:fourthColumn];
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:3], fourthColumn, @"A fourth column at index 3 should have been added with members: %@", fourthColumn);
    
    [self.testMatrix setColumnAtIndex:1 withArray:@[@10]];
    for (NSUInteger rowIndex = 0; rowIndex < 4; rowIndex++) {
        if (rowIndex == 0) {
            XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:1 rowIndex:rowIndex], @10, @"Member at 1x%lu should have been replaced with 10", (unsigned long)rowIndex);
        } else {
            XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:1 rowIndex:rowIndex], self.testMatrix.defaultMember, @"Member at 1x%lu should return the defaultMember, as that postion was not specified.", (unsigned long)rowIndex);
        }
    }
    
    [self.testMatrix setColumnAtIndex:4 withArray:@[@11, @12, @13, @14, @15]];
    XCTAssertEqual(self.testMatrix.rowCount, 5, @"Matrix should have expanded to fit the incoming column array");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:4 rowIndex:4], @15, @"Member at 4x4 should return the new member 15.");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:3 rowIndex:4], self.testMatrix.defaultMember, @"Member at 3x4 should return the defaultMember, as that postion was not specified before the matrix expansion.");
}

- (void)testSetRowAtIndexWithArray {
    NSArray *fifthRow = @[@9, @9, @9];
    [self.testMatrix setRowAtIndex:4 withArray:fifthRow];
    XCTAssertEqualObjects([self.testMatrix rowAtIndex:4], fifthRow, @"A fifth row at index 3 should have been added with members: %@", fifthRow);
    
    [self.testMatrix setRowAtIndex:1 withArray:@[@10]];
    for (NSUInteger columnIndex = 0; columnIndex < 3; columnIndex++) {
        if (columnIndex == 0) {
            XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:columnIndex rowIndex:1], @10, @"Member at %lux1 should have been replaced with 10", (unsigned long)columnIndex);
        } else {
            XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:columnIndex rowIndex:1], self.testMatrix.defaultMember, @"Member at %lux1 should return the defaultMember, as that postion was not specified.", (unsigned long)columnIndex);
        }
    }
    
    [self.testMatrix setRowAtIndex:5 withArray:@[@11, @12, @13, @14]];
    XCTAssertEqual(self.testMatrix.columnCount, 4, @"Matrix should have expanded to 4 columns to fit the incoming row array");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:3 rowIndex:5], @14, @"Member at 3x5 should return the new member 15.");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:3 rowIndex:4], self.testMatrix.defaultMember, @"Member at 3x4 should return the defaultMember, as that postion was not specified before the matrix expansion.");
}

- (void)testInsertColumnAtIndexWithArray {
    [self.testMatrix insertColumnAtIndex:1 withArray:@[@9, @9, @9, @9]];
    NSNumber *defaultMember = self.testMatrix.defaultMember;
    NSArray *comparisonColumns = @[@[@1, @2, @3, @4], @[@9, @9, @9, @9], @[@5, @6, @7, @8], @[defaultMember, defaultMember, defaultMember, defaultMember]];
    XCTAssertEqualObjects(self.testMatrix.columns, comparisonColumns, @"Matrix should have a column of 9s at index 1, the rest of the columns shifted up.");
    
    self.testMatrix.defaultMember = @10;
    defaultMember = self.testMatrix.defaultMember;
    comparisonColumns = @[@[@1, @2, @3, @4], @[@9, @9, @9, @9], @[@5, @6, @7, @8], @[defaultMember, defaultMember, defaultMember, defaultMember]];
    XCTAssertEqualObjects(self.testMatrix.columns, comparisonColumns, @"The last column should still be filled with default placeholders");
}

- (void)testInsertRowAtIndexWithArray {
    [self.testMatrix insertRowAtIndex:1 withArray:@[@9, @9, @9]];
    NSNumber *defaultMember = self.testMatrix.defaultMember;
    NSArray *comparisonRows = @[@[@1, @5, defaultMember], @[@9, @9, @9], @[@2, @6, defaultMember], @[@3, @7, defaultMember], @[@4, @8, defaultMember]];
    XCTAssertEqualObjects(self.testMatrix.rows, comparisonRows, @"Matrix should have a row of 9s at index 1, the rest of the rows shifted.");
    
    self.testMatrix.defaultMember = @10;
    defaultMember = self.testMatrix.defaultMember;
    comparisonRows = @[@[@1, @5, defaultMember], @[@9, @9, @9], @[@2, @6, defaultMember], @[@3, @7, defaultMember], @[@4, @8, defaultMember]];
    XCTAssertEqualObjects(self.testMatrix.rows, comparisonRows, @"The last member in rows indexes 0, 2, 3, 4 should still be default placeholders");
}

- (void)testFillColumnWithObject {
    [self.testMatrix fillColumn:2 withObject:@9];
    NSArray *nineArray = @[@9, @9, @9, @9];
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:2], nineArray, @"Column at index 2 should now be %@", nineArray);
    
    NSArray *tenArray = @[@10, @10, @10, @10];
    NSArray *defaultArray = @[self.testMatrix.defaultMember, self.testMatrix.defaultMember, self.testMatrix.defaultMember, self.testMatrix.defaultMember];
    [self.testMatrix fillColumn:4 withObject:@10];
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:3], defaultArray, @"Column at index 3 should be filled with default members after matrix expansion.");
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:4], tenArray, @"Column at index 4 should be filled with members of value 10");
}

- (void)testFillRowWithObject {
    [self.testMatrix fillRow:2 withObject:@9];
    NSArray *nineArray = @[@9, @9, @9];
    XCTAssertEqualObjects([self.testMatrix rowAtIndex:2], nineArray, @"Row at index 2 should now be %@", nineArray);
    
    NSArray *tenArray = @[@10, @10, @10];
    NSArray *defaultArray = @[self.testMatrix.defaultMember, self.testMatrix.defaultMember, self.testMatrix.defaultMember];
    [self.testMatrix fillRow:5 withObject:@10];
    XCTAssertEqualObjects([self.testMatrix rowAtIndex:4], defaultArray, @"Column at index 4 should be filled with default members after matrix expansion.");
    XCTAssertEqualObjects([self.testMatrix rowAtIndex:5], tenArray, @"Column at index 5 should be filled with members of value 10");
    
    NSArray *columnIdx1 = @[@5, @6, @9, @8, self.testMatrix.defaultMember, @10];
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:1], columnIdx1, @"Column at index 1 should now be: %@", columnIdx1);
}

- (void)testSetObjectAtIndexedSubscript {
    self.testMatrix[0] = @11;
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:0 rowIndex:0], @11, @"Member at position 0x0 should be 11");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:0 rowIndex:1], @2, @"Member at position 0x1 should be unchanged (@2)");
    
    self.testMatrix[12] = @13;
    NSArray *comparisonArray = @[@13, self.testMatrix.defaultMember, self.testMatrix.defaultMember, self.testMatrix.defaultMember];
    XCTAssertEqual(self.testMatrix.columnCount, 4, @"Matrix should have been expanded to 4 columns");
    XCTAssertEqualObjects([self.testMatrix columnAtIndex:3], comparisonArray, @"Column at index 3 should be: %@", comparisonArray);
}

#pragma mark - Rearranging Members

- (void)testExchangeMemberAtColumnRowWithColumnRow {
    [self.testMatrix exchangeMemberAtColumn:2 row:1 withColumn:1 row:2];
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:2 rowIndex:1], @7, @"Member at position 2x1 should now be 7");
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:1 rowIndex:2], self.testMatrix.defaultMember, @"Member at position 1x2 should now be: %@", self.testMatrix.defaultMember);
    self.testMatrix.defaultMember = @100;
    XCTAssertEqualObjects([self.testMatrix objectAtColumnIndex:1 rowIndex:2], @100, @"Member at position 1x2 should now be a default placeholder (%@)", self.testMatrix.defaultMember);
}

- (void)testTranspose {
    [self.testMatrix transpose];
    XCTAssertEqual(self.testMatrix.columnCount, 4, @"Matrix should have 4 columns after transpose");
    XCTAssertEqual(self.testMatrix.rowCount, 3, @"Matrix should have 3 rows after transpose");
    
    NSArray *comparisonColumnArray = @[@[@1, @5, @0], @[@2, @6, @0], @[@3, @7, @0], @[@4, @8, @0]];
    XCTAssertEqualObjects(self.testMatrix.columns, comparisonColumnArray, @"Columns after transpose should be: %@", comparisonColumnArray);
    
    NSArray *comparisonRowArray = @[@[@1, @2, @3, @4], @[@5, @6, @7, @8], @[@0, @0, @0, @0]];
    XCTAssertEqualObjects(self.testMatrix.rows, comparisonRowArray, @"Rows after transpose should be: %@", comparisonRowArray);
}

#pragma mark - Deriving New Matrices

- (void)testMatrixWithColumnSizeRowSize {
    AGKMatrix *newMatrix = [self.testMatrix matrixWithColumnSize:2 rowSize:2];
    
    NSArray *comparisonColumns = @[@[@1, @2], @[@3, @4]];
    XCTAssertEqual(newMatrix.columnCount, 2, @"There should be 2 columns in the new matrix");
    XCTAssertEqual(newMatrix.rowCount, 2, @"There should be 2 rows in the new matrix");
    
    XCTAssertEqualObjects(newMatrix.columns, comparisonColumns, @"Columns in new 2x2 matrix should be: %@", comparisonColumns);
}

- (void)testMatrixWithColumnSizeRowSizeAndTranspose {
    AGKMatrix *newMatrix = [self.testMatrix matrixWithColumnSize:2 rowSize:2 andTranspose:YES];
    
    NSArray *comparisonColumns = @[@[@1, @3], @[@2, @4]];
    XCTAssertEqual(newMatrix.columnCount, 2, @"There should be 2 columns in the new transposed matrix");
    XCTAssertEqual(newMatrix.rowCount, 2, @"There should be 2 rows in the new transposed matrix");
    
    XCTAssertEqualObjects(newMatrix.columns, comparisonColumns, @"Columns in new transposed 2x2 matrix should be: %@", comparisonColumns);
}

- (void)testMatrixWithColumnSizeRowSizeAndTranspose_SingleDimensionTo4x4 {
    NSArray *testMembers = @[@(0.696871), @(-0.369984), @(0.0), @(-0.000617), @(0.000447), @(0.990249), @(0.0), @(-0.000506), @(0.0), @(0.0), @(1.0), @(0.0), @(-53.266510), @(-59.347954), @(0.0), @(1.0)];
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:testMembers.count rows:1 members:testMembers];
    AGKMatrix *newMatrix = [matrix matrixWithColumnSize:4 rowSize:4 andTranspose:YES];
    
    NSArray *comparisonColumns = @[@[@(0.696871), @(0.000447), @(0.0), @(-53.266510)], @[@(-0.369984), @(0.990249), @(0.0), @(-59.347954)], @[@(0.0), @(0.0), @(1.0), @(0.0)], @[@(-0.000617), @(-0.000506), @(0.0), @(1.0)]];
    XCTAssertEqual(newMatrix.columnCount, 4, @"There should be 4 columns in the new transposed matrix");
    XCTAssertEqual(newMatrix.rowCount, 4, @"There should be 4 rows in the new transposed matrix");
    
    XCTAssertEqualObjects(newMatrix.columns, comparisonColumns, @"Columns in new transposed 4x4 matrix should be: %@", comparisonColumns);
}

- (void)testCofactorMatrix {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:3 members:@[@1, @0, @1, @2, @4, @0, @3, @5, @6]];
    NSArray *comparisonColumns = @[@[@24, @(-12), @(-2)], @[@5, @3, @(-5)], @[@(-4), @2, @4]];
    XCTAssertEqualObjects([[matrix cofactorMatrix] columns], comparisonColumns, @"Matrix columns after cofactor should be: %@", comparisonColumns);
}

- (void)testAdjointMatrix {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:3 members:@[@1, @0, @1, @2, @4, @0, @3, @5, @6]];
    NSArray *comparisonColumns = @[@[@24, @(5), @(-4)], @[@(-12), @3, @(2)], @[@(-2), @(-5), @4]];
    XCTAssertEqualObjects([[matrix adjointMatrix] columns], comparisonColumns, @"Matrix rows after adjoint should be: %@", comparisonColumns);
}

- (void)testInverseMatrix {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:3 members:@[@1, @0, @5, @2, @1, @6, @3, @4, @0]];
    AGKMatrix *inverseMatrix = [matrix inverseMatrix];
    NSArray *comparisonMembers = @[@(-24.0), @(20.0), @(-5), @(18.0), @(-15.0), @(4.0), @(5.0), @(-4.0), @(1.0)];
    
    [inverseMatrix enumerateMembersUsingBlock:^(NSNumber *member, NSUInteger index, NSUInteger columnIndex, NSUInteger rowIndex, BOOL *stop) {
        XCTAssertEqualObjects(member, comparisonMembers[index], @"Member at column %lu row %lu should be %@", (unsigned long)columnIndex, (unsigned long)rowIndex, comparisonMembers[index]);
    }];
}

- (void)testMatrixByMultiplyingWithMatrix {
    AGKMatrix *leftMatrix = [[AGKMatrix alloc] initWithColumns:2 rows:3 members:@[@0, @(-2), @0, @3, @(-1), @4]];
    AGKMatrix *rightMatrix = [[AGKMatrix alloc] initWithColumns:3 rows:2 members:@[@1, @0, @0, @3, @(-2), @(-1)]];
    AGKMatrix *matrix = [leftMatrix matrixByMultiplyingWithMatrix:rightMatrix];
    NSArray *comparisonColumns = @[@[@0, @(-2), @0], @[@9, @(-3), @12], @[@(-3), @5, @(-4)]];
    XCTAssertEqualObjects([matrix columns], comparisonColumns, @"After multiplying the left and right matrices, the result matrix's columns should be: %@", comparisonColumns);
}

#pragma mark - Matrix Operations

- (void)testMultiplyByNumber {
    [self.testMatrix multiplyByNumber:@10];
    NSArray *comparisonColumns = @[@[@10, @20, @30, @40], @[@50, @60, @70, @80], @[@0, @0, @0, @0]];
    XCTAssertEqualObjects([self.testMatrix columns], comparisonColumns, @"Every member in the matrix should have been multiplied by 10.");
}

- (void)testDeterminant {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:3 rows:3 members:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    NSNumber *determinant = [matrix determinant];
    XCTAssertEqual([determinant doubleValue], 0.0, @"Determinant of a 3x3 matrix where the members increment from 1 to 9 should be 0");
}

- (void)testCofactorAtColumnRow {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:4 rows:4 members:@[@1, @0, @0, @0, @2, @5, @8, @0, @3, @6, @9, @0, @4, @7, @10, @11]];
    NSNumber *cofactor = [matrix cofactorAtColumn:2 row:1];
    XCTAssertEqualObjects(cofactor, @(-88), @"Cofactor for position 2x1 should be -88");
}

- (void)testPerformGivensRotationOnRowAndRowWithCosineSine {
    AGKMatrix *matrix = [[AGKMatrix alloc] initWithColumns:8 rows:8 members:nil];
    for (NSUInteger index = 0; index < 8; index++) {
        [matrix setObject:@1 atColumnIndex:index rowIndex:index];
    }
    
    NSNumber *cosine = @(0.67474840847595285);
    NSNumber *sine = @(0.73804782044198791);
    [matrix performGivensRotationOnRow:0 andRow:1 withCosine:cosine sine:sine];
    
    NSArray *row0Comparison = @[cosine, sine, @0, @0, @0, @0, @0, @0];
    NSArray *row1Comparison = @[@(-1 * [sine doubleValue]), cosine, @0, @0, @0, @0, @0, @0];
    XCTAssertEqualObjects([matrix rowAtIndex:0], row0Comparison, @"After givens rotation on the first two rows of an 8x8 identity style matrix, and values cosine[%@] sine[%@], the first two rows should be:\n Row 0: %@\nRow1: %@", cosine, sine, row0Comparison, row1Comparison);
}

@end
