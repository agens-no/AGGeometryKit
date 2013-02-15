//
//  CALayer+Extensions.h
//  VG
//
//  Created by Håvard Fossli on 17.12.12.
//
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Extensions)

- (void)setNullAsActionForKeys:(NSArray *)keys;
- (void)removeAllSublayers;
- (void)ensureAnchorPointIsSetToZero;
- (void)ensureAnchorPointIs:(CGPoint)point;
- (CGPoint)outerPointForInnerPoint:(CGPoint)innerPoint;

@end
