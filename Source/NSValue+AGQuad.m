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

#import "NSValue+AGQuad.h"

@implementation NSValue (AGQuad)

+ (NSValue *)valueWithAGQuad:(AGQuad)q
{
    double values[8];
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = q.v[i];
        values[(i*2)] = p.v[0];
        values[(i*2)+1] = p.v[1];
    }
    NSValue *value = [NSValue value:&q withObjCType:@encode(double[8])];
    return value;
}

- (AGQuad)AGQuadValue
{
    AGQuad q = AGQuadZero;
    double values[8];
    [self getValue:values];
    for(int i = 0; i < 4; i++)
    {
        AGPoint p = AGPointMake(values[(i*2)], values[(i*2)+1]);
        q.v[i] = p;
    }
    return q;
}

@end
