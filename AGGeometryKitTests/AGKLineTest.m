//
// Created by Agens AS for AGGeometryKit on 13.05.14.
//

#import <XCTest/XCTest.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AGGeometryKit/AGKLine.h>

@interface AGKLineTest : XCTestCase

@end

@implementation AGKLineTest

- (void)testAGKLineLength
{
    AGKLine line = AGKLineMake(CGPointMake(12.0, 7.0), CGPointMake(17.0, 23.0));
    XCTAssertEqualWithAccuracy(AGKLineLength(line), 16.7630538, FLT_EPSILON);
}

- (void)testAGKLineIntersection
{
    {   // interesction
        AGKLine line1 = AGKLineMake(CGPointMake(10, 10), CGPointMake(20, 20));
        AGKLine line2 = AGKLineMake(CGPointMake(20, 10), CGPointMake(10, 20));

        CGPoint pointOfIntersection;
        XCTAssertTrue(AGKLineIntersection(line1, line2, &pointOfIntersection));
        XCTAssertEqualObjects([NSValue valueWithCGPoint:pointOfIntersection], [NSValue valueWithCGPoint:CGPointMake(15, 15)]);
    }
    {   // interesction
        AGKLine line1 = AGKLineMake(CGPointMake(10, 10), CGPointMake(20, 20));
        AGKLine line2 = AGKLineMake(CGPointMake(15, 5), CGPointMake(5, 15));

        CGPoint pointOfIntersection;
        XCTAssertTrue(AGKLineIntersection(line1, line2, &pointOfIntersection));
        XCTAssertEqualObjects([NSValue valueWithCGPoint:pointOfIntersection], [NSValue valueWithCGPoint:CGPointMake(10, 10)]);
    }
    {   // no intersection
        AGKLine line1 = AGKLineMake(CGPointMake(10, 10), CGPointMake(20, 20));
        AGKLine line2 = AGKLineMake(CGPointMake(10, 0), CGPointMake(0, 10));

        CGPoint pointOfIntersection;
        XCTAssertFalse(AGKLineIntersection(line1, line2, &pointOfIntersection));
        XCTAssertEqualObjects([NSValue valueWithCGPoint:pointOfIntersection], [NSValue valueWithCGPoint:CGPointZero]);
    }
}

@end
