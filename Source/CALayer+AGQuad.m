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

#import "CALayer+AGQuad.h"
#import "CAAnimationBlockDelegate.h"

@implementation CALayer (AGQuad)

@dynamic quadrilateral;

+ (CAKeyframeAnimation *)animationBetweenQuadrilateral:(AGQuad)quad1
                                      andQuadrilateral:(AGQuad)quad2
                                                  rect:(CGRect)rect
                                     forNumberOfFrames:(NSUInteger)numberOfFrames
                                                 delay:(NSTimeInterval)delay
                                              duration:(NSTimeInterval)duration
                                          easeFunction:(double(^)(double p))progressFunction
                                               onStart:(void(^)(void))onStart
                                            onComplete:(void(^)(BOOL finished))onComplete
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = CACurrentMediaTime() + delay;

    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfFrames];

    for(int i = 0; i < numberOfFrames; i++)
    {
        double p = progressFunction((double)i / (double)numberOfFrames);
        AGQuad quad = AGQuadInterpolation(quad1, quad2, p);
        CATransform3D transform = CATransform3DWithQuadFromBounds(quad, rect);
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [values addObject:value];
    }

    animation.values = values;
    animation.delegate = [CAAnimationBlockDelegate newWithAnimationDidStart:onStart didStop:onComplete];

    return animation;
}

+ (CAKeyframeAnimation *)animationBetweenQuadrilateral:(AGQuad)quad1
                                      andQuadrilateral:(AGQuad)quad2
                                                  rect:(CGRect)rect
                                     forNumberOfFrames:(NSUInteger)numberOfFrames
                                                 delay:(NSTimeInterval)delay
                                              duration:(NSTimeInterval)duration
                                          easeFunction:(double(^)(double p))progressFunction
                                            onComplete:(void(^)(BOOL finished))onComplete
{
    return [self animationBetweenQuadrilateral:quad1
                              andQuadrilateral:quad2
                                          rect:rect
                             forNumberOfFrames:numberOfFrames
                                         delay:delay
                                      duration:duration
                                  easeFunction:progressFunction
                                       onStart:nil
                                    onComplete:onComplete];
}

- (AGQuad)quadrilateral
{
    CGPoint tl = [self outerPointForInnerPoint:CGPointMake(0, 0)];
    CGPoint tr = [self outerPointForInnerPoint:CGPointMake(self.bounds.size.width, 0)];
    CGPoint br = [self outerPointForInnerPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    CGPoint bl = [self outerPointForInnerPoint:CGPointMake(0, self.bounds.size.height)];
    
    AGQuad q = AGQuadMakeWithCGPoints(tl, tr, br, bl);
    
    return q;
}

- (void)setQuadrilateral:(AGQuad)quadrilateral
{
    [self ensureAnchorPointIsSetToZero];
    
    if(!AGQuadEqual(quadrilateral, AGQuadZero))
    {
        CATransform3D t = CATransform3DWithQuadFromBounds(quadrilateral, self.bounds);
        self.transform = t;
    }
}

- (AGQuad)convertAGQuad:(AGQuad)quad fromLayer:(CALayer *)l
{
    CGPoint tl = [self convertPoint:AGPointAsCGPoint(quad.tl) fromLayer:l];
    CGPoint tr = [self convertPoint:AGPointAsCGPoint(quad.tr) fromLayer:l];
    CGPoint br = [self convertPoint:AGPointAsCGPoint(quad.br) fromLayer:l];
    CGPoint bl = [self convertPoint:AGPointAsCGPoint(quad.bl) fromLayer:l];

    AGQuad q = AGQuadMakeWithCGPoints(tl, tr, br, bl);
    
    return q;
}

- (AGQuad)convertAGQuad:(AGQuad)quad toLayer:(CALayer *)l
{
    CGPoint tl = [self convertPoint:AGPointAsCGPoint(quad.tl) toLayer:l];
    CGPoint tr = [self convertPoint:AGPointAsCGPoint(quad.tr) toLayer:l];
    CGPoint br = [self convertPoint:AGPointAsCGPoint(quad.br) toLayer:l];
    CGPoint bl = [self convertPoint:AGPointAsCGPoint(quad.bl) toLayer:l];
    
    AGQuad q = AGQuadMakeWithCGPoints(tl, tr, br, bl);
    
    return q;
}

- (void)animateFromQuadrilateral:(AGQuad)quad1
                 toQuadrilateral:(AGQuad)quad2
               forNumberOfFrames:(NSUInteger)numberOfFrames
                        duration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
                         animKey:(NSString *)animKey
                    easeFunction:(double(^)(double p))progressFunction
                      onComplete:(void(^)(BOOL finished))onComplete
{
    if(!CGPointEqualToPoint(self.anchorPoint, CGPointZero))
    {
        [NSException raise:NSInternalInconsistencyException format:@"Before using any quadrilaterals the layers anchorPoint property must be {0, 0}. You may use the category method -[CALayer ensureAnchorPointIsSetToZero]"];
    }
    
    [CATransaction begin];

    __weak __typeof__(self) wself = self;

    CAKeyframeAnimation *anim = [[self class] animationBetweenQuadrilateral:quad1
                                                           andQuadrilateral:quad2
                                                                       rect:self.bounds
                                                          forNumberOfFrames:numberOfFrames
                                                                      delay:delay
                                                                   duration:duration
                                                               easeFunction:progressFunction
                                                                    onStart:^{
                                                                        wself.quadrilateral = quad2;
                                                                    } onComplete:^(BOOL finished) {
                                                                        if(finished)
                                                                        {
                                                                            [wself removeAnimationForKey:animKey];
                                                                        }
                                                                        onComplete(finished);
                                                                    }];

    anim.removedOnCompletion = NO;

    [self addAnimation:anim forKey:animKey];

    [CATransaction commit];
}

- (void)animateFromPresentedStateToQuadrilateral:(AGQuad)quad
                               forNumberOfFrames:(NSUInteger)numberOfFrames
                                        duration:(NSTimeInterval)duration
                                           delay:(NSTimeInterval)delay
                                         animKey:(NSString *)animKey
                                    easeFunction:(double(^)(double p))progressFunction
                                      onComplete:(void(^)(BOOL finished))onComplete
{
    AGQuad currentQuad = [(CALayer *)[self presentationLayer] quadrilateral];
    
    [self animateFromQuadrilateral:currentQuad
                   toQuadrilateral:quad
                 forNumberOfFrames:numberOfFrames
                          duration:duration
                             delay:delay
                           animKey:animKey
                      easeFunction:progressFunction
                        onComplete:onComplete];
}


@end