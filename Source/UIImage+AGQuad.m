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


@end
