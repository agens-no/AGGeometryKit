//
//  AGCoreAnimationBlockDelegate.h
//  AGQuad
//
//  Created by Håvard Fossli on 18.02.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CAAnimation.h>

@interface CAAnimationBlockDelegate : NSObject

@property (nonatomic, copy) void (^onAnimationDidStart)();
@property (nonatomic, copy) void (^onAnimationDidStop)(BOOL finished);
@property (nonatomic, assign) BOOL autoRemoveBlocks; // defaults to YES - will clear blocks after calling onAnimationDidStop

@end
