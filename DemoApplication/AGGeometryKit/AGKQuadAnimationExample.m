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

#import "AGKQuadAnimationExample.h"
#import "AGKQuad.h"
#import "easing.h"
#import "CALayer+AGKQuad.h"
#import "CALayer+AGK+Methods.h"

@interface AGKQuadAnimationExample ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) AGKQuad originalQuad;

@end


@implementation AGKQuadAnimationExample

- (void)viewDidLoad
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [self.imageView addGestureRecognizer:tapRecognizer];

    [self.imageView.layer ensureAnchorPointIsSetToZero];
    self.originalQuad = self.imageView.layer.quadrilateral;

    [super viewDidLoad];
}

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Tap recognized. Logging just to show that we are receiving touch correctly even when animating.");
}

- (IBAction)changeToSquareShape:(id)sender
{
    AGKQuad quad = self.originalQuad;
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape1:(id)sender
{
    AGKQuad quad = self.originalQuad;
    quad.tr.y += 70;
    quad.tr.x -= 20;
    quad.br.x += 10;
    quad.br.y -= 30;
    quad.bl.x -= 40;
    quad.tl.x += 40;
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape2:(id)sender
{
    AGKQuad quad = self.originalQuad;
    quad.tr.y -= 125;
    quad.br.y += 65;
    quad.bl.x += 40;
    quad.tl.x -= 40;
    [self animateToQuad:quad];
}

- (void)animateToQuad:(AGKQuad)quad
{
    NSLog(@"Animating from:\n    %@", NSStringFromAGKQuad(self.imageView.layer.quadrilateral));
    NSLog(@"Animating to:  \n    %@", NSStringFromAGKQuad(quad));
    
    NSTimeInterval duration = 2.0;
    
    double (^interpolationFunction)(double) = ^(double p) {
        return (double) ElasticEaseOut(p);
    };
    
    void (^onAnimComplete)(BOOL finished) = ^(BOOL finished) {
        NSString *quadInfoString = NSStringFromAGKQuad([[self.imageView.layer presentationLayer] quadrilateral]);
        NSLog(@"Animation done (%@):\n    %@", finished ? @"FINISHED" : @"CANCELLED", quadInfoString);
    };
    
    [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad
                                                 forNumberOfFrames:duration * 60
                                                          duration:duration
                                                             delay:0.0
                                                           animKey:@"demo"
                                                      easeFunction:interpolationFunction
                                                        onComplete:onAnimComplete];
}

@end
