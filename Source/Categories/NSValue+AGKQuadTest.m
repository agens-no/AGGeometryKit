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

- (AGKQuad)createSampleQuad
{
    AGKQuad q = AGKQuadMake(CGPointMake(150.00200125, 100.12462343),
                CGPointMake(740.64351237, -20.0123131),
                CGPointMake(50.12362, 120.7532141),
                CGPointMake(-50.4312412, 300.643835123));
        return q;
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
