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

#import "UIImage+AGQuad.h"
#import "pthread.h"
#import <QuartzCore/QuartzCore.h>
#import "CGImageRef+CATransform3D.h"
#import "UIImage+CATransform3D.h"

@implementation UIImage (AGQuad)

- (UIImage *)imageWithQuad:(AGQuad)quad scale:(CGFloat)scale
{
    AGQuad scaledQuad = AGQuadApplyCATransform3D(quad, CATransform3DMakeScale(scale, scale, 1.0));
    CATransform3D transform = CATransform3DWithQuadFromBounds(scaledQuad, (CGRect){CGPointZero, self.size});
    CGImageRef imageRef = CGImageDrawWithCATransform3D(self.CGImage, transform, CGPointZero, self.size, 1.0);
    return [UIImage imageWithCGImage:imageRef];
}

- (UIImage *)cropToQuad:(AGQuad)quad outputSize:(CGSize)size
{
    size = self.size;
    
    quad = AGQuadMakeWithCGSize(size);
    quad.tl.x += 50;
    quad.tl.y += 100;
    
    CGRect bounds = (CGRect){CGPointZero, size};
    CATransform3D t1 = CATransform3DWithQuadFromBounds(quad, bounds);
    CATransform3D t2 = CATransform3DConcat(t1, t1);
    CATransform3D t3 = CATransform3DInvert(t2);
    
    //t3 = CATransform3DMakeRotation(0.4, 0, 0, 1);
    //t3 = CATransform3DMakeScale(1, 2, 1);
    //t3 = CATransform3DIdentity;
    
    return [self imageWithTransform:t1 anchorPoint:CGPointMake(1.0, 1.0)];
    
    static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
    static UIImageView *imageView;
    static UIView *superview;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        superview = [[UIView alloc] init];
        imageView = [[UIImageView alloc] init];
        [superview addSubview:imageView];
    });
    
    if(pthread_mutex_lock(&mtx))
    {
        [NSException raise:NSInternalInconsistencyException format:@"pthread_mutex_lock failed"];
    }
    
    imageView.image = self;
    superview.bounds = (CGRect){CGPointZero, self.size};
    imageView.frame = superview.bounds;
    
    
    
    imageView.layer.transform = t1;
    
    imageView.layer.transform = CATransform3DMakeScale(1.0, 2.0, 0);
    //imageView.transform = CGAffineTransformMakeRotation(0.5);
    imageView.layer.transform = CATransform3DMakeRotation(0.5, 0.2, 0.2, 1.0);
    imageView.alpha = 0.8;
    
    imageView.transform = CATransform3DGetAffineTransform(t1);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, self.scale);
    [superview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image = nil;
    
    if(pthread_mutex_unlock(&mtx) != 0)
    {
        [NSException raise:NSInternalInconsistencyException format:@"pthread_mutex_unlock failed"];
    }
    
    return image;
}

@end
