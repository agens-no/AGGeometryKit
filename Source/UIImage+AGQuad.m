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

@implementation UIImage (AGQuad)


- (UIImage *)imageWithTransform:(CATransform3D)transform anchorPoint:(CGPoint)anchorPoint size:(CGSize)size
{
    CGImageRef imageRef = CGImageDrawWithCATransform3D(self.CGImage, transform, anchorPoint, size, self.scale);
    return [UIImage imageWithCGImage:imageRef];
}

// http://stackoverflow.com/a/13850972/202451

CGImageRef CGImageDrawWithCATransform3D(CGImageRef imageRef,
                                           CATransform3D transform,
                                           CGPoint anchorPoint,
                                           CGSize size,
                                           CGFloat scale)
{
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CATransform3D translateDueToAnchor = CATransform3DMakeTranslation(size.width * (-anchorPoint.x),
                                                                      size.height * (-anchorPoint.y),
                                                                      0);
    CATransform3D translateDueToDisposition = CATransform3DMakeTranslation(size.width * (-0.5 + anchorPoint.x),
                                                                           size.height * (-0.5 + anchorPoint.y),
                                                                           0);
    
    transform = CATransform3DConcat(translateDueToAnchor, transform);
    transform = CATransform3DConcat(transform, translateDueToDisposition);
    
    float denominatorx = transform.m12 * transform.m21 - transform.m11  * transform.m22 + transform.m14 * transform.m22 * transform.m41 - transform.m12 * transform.m24 * transform.m41 - transform.m14 * transform.m21 * transform.m42 +
    transform.m11 * transform.m24 * transform.m42;
    
    float denominatory = -transform.m12 *transform.m21 + transform.m11 *transform.m22 - transform.m14 *transform.m22 *transform.m41 + transform.m12 *transform.m24 *transform.m41 + transform.m14 *transform.m21 *transform.m42 -
    transform.m11* transform.m24 *transform.m42;
    
    float denominatorw = transform.m12 *transform.m21 - transform.m11 *transform.m22 + transform.m14 *transform.m22 *transform.m41 - transform.m12 *transform.m24 *transform.m41 - transform.m14 *transform.m21 *transform.m42 +
    transform.m11 *transform.m24 *transform.m42;
    
    if (UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    } else
    {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef ctx;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *inputData = malloc(height * width * 4);
    unsigned char *outputData = malloc(height * width * 4);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(inputData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    context = CGBitmapContextCreate(outputData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    
    for (int ii = 0 ; ii < width * height ; ++ii)
    {
        int x = ii % width;
        int y = ii / width;
        int indexOutput = 4 * x + 4 * width * y;
        
        CGPoint p = modelToScreen((x*2.0/scale - size.width)/2.0,
                                  (y*2.0/scale - size.height)/2.0,
                                  transform,
                                  denominatorx,
                                  denominatory,
                                  denominatorw);
        
        p.x *= scale;
        p.y *= scale;
        
        int indexInput = 4*(int)p.x + (4*width*(int)p.y);
        
        if (p.x >= width || p.x < 0 || p.y >= height || p.y < 0 || indexInput >  width * height *4)
        {
            outputData[indexOutput] = 0.0;
            outputData[indexOutput+1] = 0.0;
            outputData[indexOutput+2] = 0.0;
            outputData[indexOutput+3] = 0.0;
            
        }
        else
        {
            outputData[indexOutput] = inputData[indexInput];
            outputData[indexOutput+1] = inputData[indexInput + 1];
            outputData[indexOutput+2] = inputData[indexInput + 2];
            outputData[indexOutput+3] = 255.0;
        }
    }
    
    ctx = CGBitmapContextCreate(outputData,
                                width,
                                height,
                                8,
                                CGImageGetBytesPerRow(imageRef),
                                CGImageGetColorSpace(imageRef),
                                kCGImageAlphaPremultipliedLast
                                );
    
    imageRef = CGBitmapContextCreateImage(ctx);
    
    CGContextRelease(ctx);
    free(inputData);
    free(outputData);
    
    return imageRef;
}

static CGPoint modelToScreen(float x,
                             float y,
                             CATransform3D _transform,
                             float _denominatorx,
                             float _denominatory,
                             float _denominatorw)
{
    float xp = (_transform.m22 *_transform.m41 - _transform.m21 *_transform.m42 - _transform.m22* x + _transform.m24 *_transform.m42 *x + _transform.m21* y - _transform.m24* _transform.m41* y) / _denominatorx;
    float yp = (-_transform.m11 *_transform.m42 + _transform.m12 * (_transform.m41 - x) + _transform.m14 *_transform.m42 *x + _transform.m11 *y - _transform.m14 *_transform.m41* y) / _denominatory;
    float wp = (_transform.m12 *_transform.m21 - _transform.m11 *_transform.m22 + _transform.m14*_transform.m22* x - _transform.m12 *_transform.m24* x - _transform.m14 *_transform.m21* y + _transform.m11 *_transform.m24 *y) / _denominatorw;
    
    CGPoint result = CGPointMake(xp/wp, yp/wp);
    return result;
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
    
    return [self imageWithTransform:t1 anchorPoint:CGPointMake(1.0, 1.0) size:size];
    
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
