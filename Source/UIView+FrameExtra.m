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

#import "UIView+FrameExtra.h"
#import "CGGeometry+Extra.h"


@implementation UIView (FrameExtra)

@dynamic frameSize;
@dynamic frameWidthHalf;
@dynamic frameHeightHalf;
@dynamic frameOrigin;
@dynamic frameMinX;
@dynamic frameMinY;
@dynamic frameMidX;
@dynamic frameMidY;
@dynamic frameMaxX;
@dynamic frameMaxY;
@dynamic frameWidth;
@dynamic frameHeight;
@dynamic boundsOrigin;
@dynamic boundsSize;
@dynamic boundsWidth;
@dynamic boundsHeight;
@dynamic boundsCenter;
@dynamic boundsWidthHalf;
@dynamic boundsHeightHalf;
@dynamic centerX;
@dynamic centerY;

- (CGSize)frameSize
{
	return self.frame.size;
}

- (void)setFrameSize:(CGSize)value
{
	self.frame = CGRectWithSize(self.frame, value);
}

- (CGFloat)frameWidth
{
	return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)value
{
	self.frame = CGRectWithWidth(self.frame, value);
}

- (CGFloat)frameHeight
{
	return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)value
{
	self.frame = CGRectWithHeight(self.frame, value);
}

- (CGFloat)frameHeightHalf
{
	return self.frameHeight / 2.0;
}

- (CGFloat)frameWidthHalf
{
	return self.frameWidth / 2.0;
}

- (CGPoint)frameOrigin
{
	return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)value
{
	self.frame = CGRectWithOrigin(self.frame, value);
}

- (CGFloat)frameMinX
{
    return CGRectGetMinX(self.frame);
}

- (void)setFrameMinX:(CGFloat)value
{
    self.frame = CGRectWithOriginMinX(self.frame, value);
}

- (CGFloat)frameMinY
{
    return CGRectGetMinY(self.frame);
}

- (void)setFrameMinY:(CGFloat)value
{
    self.frame = CGRectWithOriginMinY(self.frame, value);
}

- (CGFloat)frameMidX
{
    return CGRectGetMidX(self.frame);
}

- (void)setFrameMidX:(CGFloat)value
{
    self.frame = CGRectWithOriginMidX(self.frame, value);
}

- (CGFloat)frameMidY
{
    return CGRectGetMidY(self.frame);
}

- (void)setFrameMidY:(CGFloat)value
{
    self.frame = CGRectWithOriginMidY(self.frame, value);
}

- (CGFloat)frameMaxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setFrameMaxX:(CGFloat)value
{
    self.frame = CGRectWithOriginMaxX(self.frame, value);
}

- (CGFloat)frameMaxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setFrameMaxY:(CGFloat)value
{
    self.frame = CGRectWithOriginMaxY(self.frame, value);
}

- (CGPoint)boundsOrigin
{
	return self.bounds.origin;
}

- (void)setBoundsOrigin:(CGPoint)value
{
	self.bounds = CGRectWithOrigin(self.bounds, value);
}

- (CGSize)boundsSize
{
	return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)value
{
	self.bounds = CGRectWithSize(self.bounds, value);
}

- (CGFloat)boundsWidth
{
	return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)value
{
	self.bounds = CGRectWithWidth(self.bounds, value);
}

- (CGFloat)boundsHeight
{
	return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)newHeight
{
	self.bounds = CGRectWithHeight(self.bounds, newHeight);
}

- (CGFloat)boundsHeightHalf
{
	return self.boundsHeight / 2.0;
}

- (CGFloat)boundsWidthHalf
{
	return self.boundsWidth / 2.0;
}

- (CGPoint)boundsCenter
{
    return CGPointMake(self.boundsWidthHalf, self.boundsHeightHalf);
}

- (CGFloat)centerX
{
	return self.center.x;
}

- (void)setCenterX:(CGFloat)newX
{
	self.center = CGPointMake(newX, self.center.y);
}

- (CGFloat)centerY
{
	return self.center.y;
}

- (void)setCenterY:(CGFloat)newY
{
	self.center = CGPointMake(self.center.x, newY);
}

@end
