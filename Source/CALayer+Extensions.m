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

#import "CALayer+Extensions.h"
#import <objc/runtime.h>

@implementation CALayer (Extensions)

- (void)setNullAsActionForKeys:(NSArray *)keys
{
    NSMutableDictionary *dict = [self.actions mutableCopy];
    
    if(dict == nil)
    {
        dict = [NSMutableDictionary dictionaryWithCapacity:[keys count]];
    }
    
    for(NSString *key in keys)
    {
        [dict setObject:[NSNull null] forKey:key];
    }
    
    self.actions = dict;
}

- (void)removeAllSublayers
{
    for(CALayer *sublayer in self.sublayers)
    {
        [sublayer removeFromSuperlayer];
    }
}

- (void)ensureAnchorPointIsSetToZero
{
    [self ensureAnchorPointIs:CGPointZero];
}

- (void)ensureAnchorPointIs:(CGPoint)point
{
    if(!CGPointEqualToPoint(self.anchorPoint, point))
    {
        CGRect frame = self.frame;
        self.anchorPoint = point;
        self.frame = frame;
    }
}

- (CGPoint)outerPointForInnerPoint:(CGPoint)innerPoint
{
    if(self.superlayer == nil)
    {
        [NSException raise:NSInternalInconsistencyException format:@"To calculate the outer point for a givven inner point it is required that the layer have a superlayer. This can hopefully be improved."];
    }
    
    if(!CGPointEqualToPoint(self.anchorPoint, CGPointZero))
    {
        [NSException raise:NSInternalInconsistencyException format:@"This method is *dumb* and currently only supports anchorpoint to be 0"];
    }
    
    CGPoint outerPoint = [self convertPoint:innerPoint toLayer:self.superlayer];
    outerPoint.x -= self.position.x;
    outerPoint.y -= self.position.y;
    
    if(outerPoint.x != outerPoint.x || outerPoint.y != outerPoint.y)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Calculated NaN values from CALayer %@", self];
    }
    
    return outerPoint;
}

@end
