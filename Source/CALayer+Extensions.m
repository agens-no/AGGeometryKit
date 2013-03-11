//
//  CALayer+Extensions.m
//  VG
//
//  Created by Håvard Fossli on 17.12.12.
//
//

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
