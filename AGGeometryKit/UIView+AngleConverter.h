//
//  UIView+AngleConverter.h
//  ViewAngleTest
//
//  Created by Odd Magne Hågensen on 12.03.13.
//  Copyright (c) 2013 Odd Magne Hågensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AngleConverter)

- (CGFloat)convertAngle:(CGFloat)angle toView:(UIView *)view;
- (CGFloat)convertAngleOfViewInRelationToView:(UIView *)view;

@end
