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

#import "QuadControlsExample.h"
#import <AGGeometryKit/AGGeometryKit.h>

@interface AGControlPointView : UIView

@end

@interface QuadControlsExample () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *topLeftControl;
@property (nonatomic, strong) IBOutlet UIView *topRightControl;
@property (nonatomic, strong) IBOutlet UIView *bottomLeftControl;
@property (nonatomic, strong) IBOutlet UIView *bottomRightControl;
@property (nonatomic, strong) IBOutlet UIView *maskView;
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;

@end


@implementation QuadControlsExample

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.imageView.layer ensureAnchorPointIsSetToZero];

    self.imageView.layer.quadrilateral = AGKQuadMake(self.topLeftControl.center,
                                                     self.topRightControl.center,
                                                     self.bottomRightControl.center,
                                                     self.bottomLeftControl.center);

    [self createOverlay];
    [self updateOverlay];
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

    self.imageView.layer.quadrilateral = AGKQuadMake(self.topLeftControl.center,
                                                     self.topRightControl.center,
                                                     self.bottomRightControl.center,
                                                     self.bottomLeftControl.center);

    [self updateOverlay];
}

- (void)createOverlay
{
    self.maskView = [[UIView alloc] init];
    self.maskView.center = self.imageView.center;
    self.maskView.layer.shadowColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    self.maskView.layer.shadowOpacity = 1.0;
    self.maskView.layer.shadowRadius = 0.0;
    self.maskView.layer.shadowOffset = CGSizeZero;
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.maskView.userInteractionEnabled = NO;
    self.maskView.hidden = !self.switchControl.on;
    [self.view insertSubview:self.maskView aboveSubview:self.imageView];
}

- (void)updateOverlay
{
    UIColor *redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    UIColor *greenColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5];

    AGKQuad quad = AGKQuadMake(self.topLeftControl.center,
                               self.topRightControl.center,
                               self.bottomRightControl.center,
                               self.bottomLeftControl.center);

    self.maskView.layer.position = CGPointZero;
    self.maskView.layer.shadowPath = [UIBezierPath bezierPathWithAGKQuad:quad].CGPath;
    self.maskView.layer.shadowColor = AGKQuadIsConvex(quad) ? greenColor.CGColor : redColor.CGColor;
}
	
- (IBAction)toggleDisplayOverlay:(UISwitch *)switchControl
{
    self.maskView.hidden = !self.switchControl.on;
}

@end
