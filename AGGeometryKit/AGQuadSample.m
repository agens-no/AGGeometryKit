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

#import "AGQuadSample.h"
#import "AGQuad.h"
#import "easing.h"
#import "CALayer+AGQuad.h"

@interface AGQuadSample ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end


@implementation AGQuadSample

#pragma mark - Construct and destruct

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [self.imageView.layer ensureAnchorPointIsSetToZero];
    [super viewDidLoad];
}

- (void)dealloc
{
}

- (void)didReceiveMemoryWarning
{    
    [super didReceiveMemoryWarning];
}

#pragma mark - View events

- (IBAction)changeToSquareShape:(id)sender
{
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape1:(id)sender
{
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    quad.tr.y += 125;
    quad.br.y -= 65;
    quad.bl.x -= 40;
    quad.tl.x += 40;
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape2:(id)sender
{
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    quad.tr.y -= 125;
    quad.br.y += 65;
    quad.bl.x += 40;
    quad.tl.x -= 40;
    [self animateToQuad:quad];
}

#pragma mark - Convinience methods

- (void)animateToQuad:(AGQuad)quad
{
    NSLog(@"Animating from:\n    %@", NSStringFromAGQuad(self.imageView.layer.quadrilateral));
    NSLog(@"Animating to:\n    %@", NSStringFromAGQuad(quad));
    
    NSTimeInterval duration = 2.0;
    
    double (^interpolationFunction)(double) = ^(double p) {
        return (double) ElasticEaseOut(p);
    };
    
    void (^onAnimComplete)(BOOL finished) = ^(BOOL finished) {
        NSString *quadInfoString = NSStringFromAGQuad([[self.imageView.layer presentationLayer] quadrilateral]);
        NSLog(@"Animation done (%@):\n    %@", finished ? @"FINISHED" : @"CANCELLED", quadInfoString);
    };
    
    [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad
                                                 forNumberOfFrames:duration * 60
                                                          duration:duration
                                                             delay:0.0
                                                           animKey:@"demo"
                                             interpolationFunction:interpolationFunction
                                                        onComplete:onAnimComplete];
}

@end
