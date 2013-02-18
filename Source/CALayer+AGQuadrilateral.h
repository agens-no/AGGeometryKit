//
//  CALayer+AGQuadrilateral.h
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 15.02.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AGQuadrilateral.h"
#import "CALayer+Extensions.h"

@interface CALayer (AGQuadrilateral)

/**
 * @property AGQuadrilateral quadrilateral
 * Updating this property will update property 'transform' unless it is set to AGQuadrilateralZero
 * @discussion
 *   It is only possible to make convex transforms with quadrilaterals.
 *   So make sure your quadrilateral is convex.
 *   http://upload.wikimedia.org/wikipedia/commons/f/f1/Quadrilateral_hierarchy.png
 */
@property (nonatomic, assign) AGQuadrilateral quadrilateral;

- (void)animateFromQuadrilateral:(AGQuadrilateral)quad1
                 toQuadrilateral:(AGQuadrilateral)quad2
               forNumberOfFrames:(NSUInteger)numberOfFrames
                        duration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
                progressFunction:(double(^)(double p))progressFunction
                          forKey:(NSString *)animKey
                      onComplete:(void(^)(BOOL finished))onComplete;

- (void)animateFromPresentedStateToQuadrilateral:(AGQuadrilateral)quad
                               forNumberOfFrames:(NSUInteger)numberOfFrames
                                        duration:(NSTimeInterval)duration
                                           delay:(NSTimeInterval)delay
                                progressFunction:(double(^)(double p))progressFunction
                                          forKey:(NSString *)animKey
                                      onComplete:(void(^)(BOOL finished))onComplete;

@end