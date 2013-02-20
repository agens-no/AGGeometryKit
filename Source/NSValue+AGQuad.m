//
//  NSValue+AGQuad.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import "NSValue+AGQuad.h"

@implementation NSValue (AGQuad)

+ (NSValue *)valueWithAGQuad:(AGQuad)q
{
    NSValue *value = [NSValue value:&q withObjCType:@encode(AGQuad)];
    return value;
}

- (AGQuad)AGQuadValue
{
    AGQuad q;
    [self getValue:&q];
    return q;
}

@end
