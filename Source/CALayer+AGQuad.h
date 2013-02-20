//
//  CALayer+AGQuad.h
//  AGQuad
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AGQuad.h"
#import "CALayer+Extensions.h"

@interface CALayer (AGQuad)

/**
 * @property AGQuad quadrilateral
 * Updating this property will update property 'transform' unless it is set to AGQuadZero
 * @discussion
 *   It is only possible to make convex transforms with quadrilaterals.
 *   So make sure your quadrilateral is convex.
 *   http://upload.wikimedia.org/wikipedia/commons/f/f1/Quadrilateral_hierarchy.png
 */
@property (nonatomic, assign) AGQuad quadrilateral;

- (void)animateFromQuadrilateral:(AGQuad)quad1
                 toQuadrilateral:(AGQuad)quad2
               forNumberOfFrames:(NSUInteger)numberOfFrames
                        duration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
                progressFunction:(double(^)(double p))progressFunction
                          forKey:(NSString *)animKey
                      onComplete:(void(^)(BOOL finished))onComplete;

- (void)animateFromPresentedStateToQuadrilateral:(AGQuad)quad
                               forNumberOfFrames:(NSUInteger)numberOfFrames
                                        duration:(NSTimeInterval)duration
                                           delay:(NSTimeInterval)delay
                                progressFunction:(double(^)(double p))progressFunction
                                          forKey:(NSString *)animKey
                                      onComplete:(void(^)(BOOL finished))onComplete;

@end