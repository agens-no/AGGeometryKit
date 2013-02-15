//
//  CALayer+AGQuadrilateral.m
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import "CALayer+AGQuadrilateral.h"

@implementation CALayer (AGQuadrilateral)

@dynamic quadrilateral;

+ (CAKeyframeAnimation *)animationBetweenQuadrilateral:(AGQuadrilateral)quad1
                                      andQuadrilateral:(AGQuadrilateral)quad2
                                                  rect:(CGRect)rect
                                     forNumberOfFrames:(NSUInteger)numberOfFrames
                                              duration:(NSTimeInterval)duration
                                      progressFunction:(double(^)(double p))progressFunction
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfFrames];
    
    for(int i = 0; i < numberOfFrames; i++)
    {
        double p = progressFunction((double)i / (double)numberOfFrames);
        AGQuadrilateral quad = AGQuadrilateralInterpolation(quad1, quad2, p);
        CATransform3D transform = CATransform3DMakeRectToQuadrilateral(rect, quad);
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [values addObject:value];
    }
    
    animation.values = values;
    
    return animation;
}

- (void)setQuadrilateral:(AGQuadrilateral)quadrilateral
{
    [self ensureAnchorPointIsSetToZero];
    
    if(!AGQuadrilateralEqual(quadrilateral, AGQuadrilateralZero))
    {
        CATransform3D t = CATransform3DMakeRectToQuadrilateral(self.bounds, quadrilateral);
        self.transform = t;
    }
}

- (AGQuadrilateral)quadrilateral
{
    return AGQuadrilateralMakeWithCGRect(self.bounds);
    
    CGPoint tl = [self outerPointForInnerPoint:CGPointMake(0, 0)];
    CGPoint tr = [self outerPointForInnerPoint:CGPointMake(self.bounds.size.width, 0)];
    CGPoint br = [self outerPointForInnerPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    CGPoint bl = [self outerPointForInnerPoint:CGPointMake(0, self.bounds.size.height)];
    
    AGQuadrilateral q = AGQuadrilateralMakeWithCGPoints(tl, tr, br, bl);
    
    return q;
}


- (void)animateFromQuadrilateral:(AGQuadrilateral)quad1
                 toQuadrilateral:(AGQuadrilateral)quad2
               forNumberOfFrames:(NSUInteger)numberOfFrames
                        duration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
                progressFunction:(double(^)(double p))progressFunction
                          forKey:(NSString *)animKey
                      onComplete:(void(^)(void))onComplete
{
    if(!CGPointEqualToPoint(self.anchorPoint, CGPointZero))
    {
        [NSException raise:NSInternalInconsistencyException format:@"Before using any quadrilaterals the layers anchorPoint property must be {0, 0}. You may use the category method -[CALayer ensureAnchorPointIsSetToZero]"];
    }
    
    [CATransaction begin];
    
    CAKeyframeAnimation *anim = [[self class] animationBetweenQuadrilateral:quad1
                                                           andQuadrilateral:quad2
                                                                       rect:self.bounds
                                                          forNumberOfFrames:numberOfFrames
                                                                   duration:duration
                                                           progressFunction:progressFunction];
    
    anim.beginTime = CACurrentMediaTime() + delay;
    
    [self addAnimation:anim forKey:animKey];
    
    [CATransaction commit];
}

- (void)animateFromPresentedStateToQuadrilateral:(AGQuadrilateral)quad
                               forNumberOfFrames:(NSUInteger)numberOfFrames
                                        duration:(NSTimeInterval)duration
                                           delay:(NSTimeInterval)delay
                                progressFunction:(double(^)(double p))progressFunction
                                          forKey:(NSString *)animKey
                                      onComplete:(void(^)(void))onComplete
{
    AGQuadrilateral currentQuad = [(CALayer *)[self presentationLayer] quadrilateral];
    
    [self animateFromQuadrilateral:currentQuad toQuadrilateral:quad forNumberOfFrames:numberOfFrames duration:duration delay:delay progressFunction:progressFunction forKey:animKey onComplete:onComplete];
}


@end