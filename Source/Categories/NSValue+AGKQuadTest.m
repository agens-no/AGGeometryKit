/**
 * @class NSValueAGKQuadTest
 * @author hfossli
 */

#import <XCTest/XCTest.h>
#import "NSValue+AGKQuad.h"

@interface DummyClass : NSObject <NSCoding>
@property (nonatomic, assign) AGKQuad q;
@end

@implementation DummyClass

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSValue valueWithAGKQuad:self.q] forKey:@"q"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self)
    {
        self.q = [[aDecoder decodeObjectForKey:@"q"] AGKQuadValue];
    }
    return self;
}

@end



@interface NSValue_AGKQuad_Test : XCTestCase
@end

@implementation NSValue_AGKQuad_Test

- (void)setUp
{
    [super setUp];
}

- (AGKQuad)createSampleQuad
{
    AGKQuad q = AGKQuadMake(CGPointMake(150.00200125, 100.12462343),
                CGPointMake(740.64351237, -20.0123131),
                CGPointMake(50.12362, 120.7532141),
                CGPointMake(-50.4312412, 300.643835123));
        return q;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEncodeDecode
{
    AGKQuad original = [self createSampleQuad];
    NSValue *value = [NSValue valueWithAGKQuad:original];
    XCTAssertNotNil(value);

    AGKQuad decoded = [value AGKQuadValue];
    XCTAssertTrue(AGKQuadEqual(decoded, original), @"Not equal after decoding");
}

- (void)testNSCoderCompliance
{
    DummyClass *dummy1 = [[DummyClass alloc] init];
    dummy1.q = [self createSampleQuad];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dummy1];

    DummyClass *dummy2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    XCTAssertNotNil(dummy2);

    XCTAssertTrue(AGKQuadEqual(dummy1.q, dummy2.q), @"Not equal after decoding");
}

@end
