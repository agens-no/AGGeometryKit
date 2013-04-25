//
// Author: Håvard Fossli <hfossli@agens.no>
// Author: Marcos Fuentes http://stackoverflow.com/users/1637195/marcos-fuentes
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

#import "AGTransformPixelMapper.h"
#import <QuartzCore/QuartzCore.h>
#import "CGGeometry+Extra.h"

@interface AGTransformPixelMapper ()

@property (nonatomic, assign, readwrite) CATransform3D transform;
@property (nonatomic, assign, readwrite) CGPoint anchorPoint;
@property (nonatomic, assign, readwrite) double denominatorX;
@property (nonatomic, assign, readwrite) double denominatorY;
@property (nonatomic, assign, readwrite) double denominatorW;

@end

@implementation AGTransformPixelMapper

- (id)initWithTransform:(CATransform3D)t anchorPoint:(CGPoint)anchorPoint
{
    self = [self init];
    if(self)
    {
        
        self.denominatorX = t.m12 * t.m21 - t.m11  * t.m22 + t.m14 * t.m22 * t.m41 - t.m12 * t.m24 * t.m41 - t.m14 * t.m21 * t.m42 +
        t.m11 * t.m24 * t.m42;
        
        self.denominatorY = -t.m12 *t.m21 + t.m11 *t.m22 - t.m14 *t.m22 *t.m41 + t.m12 *t.m24 *t.m41 + t.m14 *t.m21 *t.m42 -
        t.m11* t.m24 *t.m42;
        
        self.denominatorW = t.m12 *t.m21 - t.m11 *t.m22 + t.m14 *t.m22 *t.m41 - t.m12 *t.m24 *t.m41 - t.m14 *t.m21 *t.m42 +
        t.m11 *t.m24 *t.m42;
        
        self.transform = t;
        self.anchorPoint = anchorPoint;
    }
    return self;
}

- (CGPoint)projectedPointForModelPoint:(CGPoint)point
{
    CATransform3D t = self.transform;
    double x = point.x;
    double y = point.y;
    
    double xp = (t.m22 *t.m41 - t.m21 *t.m42 - t.m22* x + t.m24 *t.m42 *x + t.m21* y - t.m24* t.m41* y) / self.denominatorX;
    double yp = (-t.m11 *t.m42 + t.m12 * (t.m41 - x) + t.m14 *t.m42 *x + t.m11 *y - t.m14 *t.m41* y) / self.denominatorY;
    double wp = (t.m12 *t.m21 - t.m11 *t.m22 + t.m14*t.m22* x - t.m12 *t.m24* x - t.m14 *t.m21* y + t.m11 *t.m24 *y) / self.denominatorW;
    
    CGPoint result = CGPointMake(xp/wp, yp/wp);
    return result;
}

- (void)mapBitmap:(unsigned char *)input
               to:(unsigned char *)output
           inSize:(CGSize)inSize
          outSize:(CGSize)outSize
            scale:(double)scale
     bitsPerPixel:(size_t)bitsPerPixel
 bitsPerComponent:(size_t)bitsPerComponent
{
    int width = inSize.width;
    int height = inSize.height;
    
    size_t bitsPerRow = bitsPerPixel * width;
    size_t bitsInTotal = width * height * bitsPerPixel;
    
    for (int ii = 0 ; ii < width * height ; ++ii)
    {
        int x = ii % width;
        int y = ii / width;
        int indexOutput = bitsPerPixel * x + bitsPerRow * y;
        
        CGPoint modelPoint = CGPointMake((x*2.0/scale - outSize.width)/2.0,
                                         (y*2.0/scale - outSize.height)/2.0);
        
        CGPoint p = [self projectedPointForModelPoint:modelPoint];
        p.x *= scale;
        p.y *= scale;
        
        int indexInput = bitsPerPixel*(int)p.x + (bitsPerRow*(int)p.y);
        BOOL isOutOfBounds = p.x >= width || p.x < 0 || p.y >= height || p.y < 0 || indexInput >  bitsInTotal;
        
        if (isOutOfBounds)
        {
            for(int j = 0; j < bitsPerPixel; j++)
            {
                output[indexOutput+j] = 0;
            }
        }
        else
        {
            for(int j = 0; j < bitsPerPixel; j++)
            {
                output[indexOutput+j] = input[indexInput+j];
            }
        }
    }
}

- (CGImageRef)createMappedImageRefFrom:(CGImageRef)imageRef scale:(double)scale
{
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerPixel = 4;
    size_t bitsPerRow = bitsPerPixel * width;
    size_t bitsPerComponent = 8;
    size_t bitsInTotal = width * height * bitsPerPixel;
    
    unsigned char *inputData = malloc(bitsInTotal);
    unsigned char *outputData = malloc(bitsInTotal);
    
    // in case not every bit is drawn into outputData (this is necessary)
    for (int ii = 0 ; ii < bitsInTotal; ++ii)
    {
        outputData[ii] = 0;
        inputData[ii] = 0;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(inputData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bitsPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    [self mapBitmap:inputData
                   to:outputData
               inSize:CGSizeMake(width, height)
              outSize:CGSizeMake(width, height)
                scale:scale
       bitsPerPixel:bitsPerPixel
     bitsPerComponent:bitsPerComponent];
    
    CGContextRef ctx;
    ctx = CGBitmapContextCreate(outputData,
                                width,
                                height,
                                bitsPerComponent,
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

@end
