//
//  AGCoreAnimationBlockDelegate.m
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 18.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "CAAnimationBlockDelegate.h"

@interface CAAnimationBlockDelegate ()

// private properties and methods

@end

@implementation CAAnimationBlockDelegate

- (id)init
{
    self = [super init];
    if(self)
    {
        _autoRemoveBlocks = YES;
    }
    return self;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if(self.onAnimationDidStart)
    {
        self.onAnimationDidStart();
    }
    if(self.autoRemoveBlocks)
    {
        self.onAnimationDidStart = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.onAnimationDidStop)
    {
        self.onAnimationDidStop(flag);
    }
    if(self.autoRemoveBlocks)
    {
        self.onAnimationDidStop = nil;
    }
}

@end
