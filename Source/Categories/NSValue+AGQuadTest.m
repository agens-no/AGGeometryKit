/**
 * @class NSValueAGQuadTest
 * @author hfossli
 */

#import <SenTestingKit/SenTestingKit.h>
#import "NSValue+AGQuad.h"

@interface DummyClass : NSObject <NSCoding>
@property (nonatomic, assign) AGQuad q;
@end

@implementation DummyClass

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSValue valueWithAGQuad:self.q] forKey:@"q"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self)
    {
        self.q = [[aDecoder decodeObjectForKey:@"q"] AGQuadValue];
    }
    return self;
}

@end



@interface NSValue_AGQuad_Test : SenTestCase
@end

@implementation NSValue_AGQuad_Test

- (void)setUp
{
    [super setUp];
}

- (AGQuad)createSampleQuad
{
    AGQuad q = AGQuadMake(CGPointMake(150.00200125, 100.12462343),
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
    AGQuad original = [self createSampleQuad];
    NSValue *value = [NSValue valueWithAGQuad:original];
    STAssertNotNil(value, nil);

    AGQuad decoded = [value AGQuadValue];
    STAssertTrue(AGQuadEqual(decoded, original), @"Not equal after decoding");
}

- (void)testNSCoderCompliance
{
    DummyClass *dummy1 = [[DummyClass alloc] init];
    dummy1.q = [self createSampleQuad];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dummy1];

    DummyClass *dummy2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    STAssertNotNil(dummy2, nil);

    STAssertTrue(AGQuadEqual(dummy1.q, dummy2.q), @"Not equal after decoding");
}

@end
