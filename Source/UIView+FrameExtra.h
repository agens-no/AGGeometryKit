//
//  UIView+position.h
//  AGUIExtensions
//
//  Created by Håvard Fossli on 09.12.10.
//  Copyright 2010 Agens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExtra)

@property (nonatomic, assign) CGSize frameSize;
@property (nonatomic, readonly) CGFloat frameWidthHalf;
@property (nonatomic, readonly) CGFloat frameHeightHalf;

@property (nonatomic, assign) CGPoint frameOrigin;
@property (nonatomic, assign) CGFloat frameMinX;
@property (nonatomic, assign) CGFloat frameMinY;
@property (nonatomic, assign) CGFloat frameMidX;
@property (nonatomic, assign) CGFloat frameMidY;
@property (nonatomic, assign) CGFloat frameMaxX;
@property (nonatomic, assign) CGFloat frameMaxY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;

@property (nonatomic, assign) CGPoint boundsOrigin;
@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;

@property (nonatomic, readonly) CGPoint boundsCenter;
@property (nonatomic, readonly) CGFloat boundsWidthHalf;
@property (nonatomic, readonly) CGFloat boundsHeightHalf;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end