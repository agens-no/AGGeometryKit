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

#import "NSValue+AGKQuad.h"

@implementation NSValue (AGKQuad)

+ (NSValue *)valueWithAGKQuad:(AGKQuad)q
{
    CGFloat values[8];
    
    values[0] = q.tl.x;
    values[1] = q.tl.y;
    values[2] = q.tr.x;
    values[3] = q.tr.y;
    values[4] = q.br.x;
    values[5] = q.br.y;
    values[6] = q.bl.x;
    values[7] = q.bl.y;
    
    NSValue *value = [NSValue value:&q withObjCType:@encode(CGFloat[8])];
    return value;
}

- (AGKQuad)AGKQuadValue
{
    AGKQuad q = AGKQuadZero;
    CGFloat values[8];
    [self getValue:values];
    
    q.tl = CGPointMake(values[0], values[1]);
    q.tr = CGPointMake(values[2], values[3]);
    q.br = CGPointMake(values[4], values[5]);
    q.bl = CGPointMake(values[6], values[7]);
    
    return q;
}

@end
