//
// Authors:
// Håvard Fossli <hfossli@agens.no>
// Logan Holmes @snown
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

#import "CATransform3DWithUIImageExample.h"
#import <AGGeometryKit/AGGeometryKit.h>
#import "JAValueToString.h"

@interface CATransform3DWithUIImageExample ()  <UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIView *topLeftControl;
@property (nonatomic, strong) IBOutlet UIView *topRightControl;
@property (nonatomic, strong) IBOutlet UIView *bottomLeftControl;
@property (nonatomic, strong) IBOutlet UIView *bottomRightControl;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) IBOutlet UIImageView *source;
@property (nonatomic, strong) IBOutlet UIImageView *result;

@end


@implementation CATransform3DWithUIImageExample

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.source.layer ensureAnchorPointIsSetToZero];

    [self createOverlay];

    [self cropSampleTwo];
}

- (IBAction)cropSampleOne
{
    self.topLeftControl.center = CGPointMake(13.5, 166.5);
    self.topRightControl.center = CGPointMake(257.5, 178.5);
    self.bottomLeftControl.center = CGPointMake(1.5, 345.5);
    self.bottomRightControl.center = CGPointMake(251.5, 332.5);

    [self updateOverlay];
    [self produce];
}

- (IBAction)cropSampleTwo
{
    self.topLeftControl.center = CGPointMake(272.5, 31.5);
    self.topRightControl.center = CGPointMake(434.5, 53.5);
    self.bottomLeftControl.center = CGPointMake(271.5, 181.5);
    self.bottomRightControl.center = CGPointMake(435.5, 187.5);

    [self updateOverlay];
    [self produce];
}

- (void)produce
{
    UIImage *image = self.source.image;

    AGKQuad quad;
    quad.tl.x = AGKRemap(self.topLeftControl.center.x, 0, self.source.boundsWidth, 0, image.size.width);
    quad.tl.y = AGKRemap(self.topLeftControl.center.y, 0, self.source.boundsHeight, 0, image.size.height);
    quad.tr.x = AGKRemap(self.topRightControl.center.x, 0, self.source.boundsWidth, 0, image.size.width);
    quad.tr.y = AGKRemap(self.topRightControl.center.y, 0, self.source.boundsHeight, 0, image.size.height);
    quad.bl.x = AGKRemap(self.bottomLeftControl.center.x, 0, self.source.boundsWidth, 0, image.size.width);
    quad.bl.y = AGKRemap(self.bottomLeftControl.center.y, 0, self.source.boundsHeight, 0, image.size.height);
    quad.br.x = AGKRemap(self.bottomRightControl.center.x, 0, self.source.boundsWidth, 0, image.size.width);
    quad.br.y = AGKRemap(self.bottomRightControl.center.y, 0, self.source.boundsHeight, 0, image.size.height);

    [self cropImage:image toQuad:quad];
}

- (void)cropImage:(UIImage *)image toQuad:(AGKQuad)quad
{
    static int count = 0;
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("agk.cropImageToQuad", 0);
    });

    count++;
    [self.activityIndicator startAnimating];

    dispatch_async(queue, ^{

        UIImage *result = [image imageByCroppingToQuad:quad destinationSize:self.result.boundsSize];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.result.image = result;

            count--;

            if(count == 0)
            {
                [self.activityIndicator stopAnimating];
            }
        });
    });
}

- (void)createOverlay
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.anchorPoint = CGPointZero;
    [self.shapeLayer setNullAsActionForKeys:@[@"transform"]];
    self.shapeLayer.frame = self.source.frame;
    self.shapeLayer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    [self.source.superview.layer insertSublayer:self.shapeLayer above:self.source.layer];
}

- (void)updateOverlay
{
    AGKQuad quad = AGKQuadMake(self.topLeftControl.center,
                               self.topRightControl.center,
                               self.bottomRightControl.center,
                               self.bottomLeftControl.center);

    self.shapeLayer.position = CGPointZero;
    self.shapeLayer.quadrilateral = quad;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (IBAction)panGestureChanged:(UIPanGestureRecognizer *)recognizer
{
    UIImageView *controlPointView = (UIImageView *)[recognizer view];
    controlPointView.highlighted = recognizer.state == UIGestureRecognizerStateChanged;

    CGPoint translation = [recognizer translationInView:self.view];
    controlPointView.centerX += translation.x;
    controlPointView.centerY += translation.y;
    [recognizer setTranslation:CGPointZero inView:self.view];

    [self updateOverlay];

    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self produce];
    }
}

@end
