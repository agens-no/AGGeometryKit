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

#import "AGKCATransform3DWithUIImageExample.h"
#import "AGKQuad.h"
#import "CALayer+AGKQuad.h"
#import "UIImage+AGKQuad.h"
#import "JAValueToString.h"
#import "CALayer+AGK+Methods.h"

@interface AGKCATransform3DWithUIImageExample ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView1;
@property (nonatomic, strong) IBOutlet UIImageView *imageView2;

@end


@implementation AGKCATransform3DWithUIImageExample

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.imageView1.layer ensureAnchorPointIsSetToZero];
}

- (IBAction)makeBlueFill:(id)sender
{
    AGKQuad quad = [self quadForBlueToFill];
    
    self.imageView2.image = [[self originalImage] imageWithPerspectiveCorrectionFromQuad:quad];
}

- (IBAction)makePurpleFill:(id)sender
{
    AGKQuad quad = [self quadForPurpleFill];
    
    self.imageView2.image = [[self originalImage] imageWithPerspectiveCorrectionFromQuad:quad];
}

- (UIImage *)originalImage
{
    return self.imageView1.image;
}

- (AGKQuad)quadForBlueToFill
{
    // These points are the four corners of the sub quadrilateral that we want
    // to perspective correct. They could be gathered by dragging control points
    // to those corners like in the "Quad Controls" example.
    AGKQuad quad;
    quad.tl = CGPointMake(76.38, 88.47);
    quad.tr = CGPointMake(537.99, 260.94);
    quad.br = CGPointMake(467.15, 509.66);
    quad.bl = CGPointMake(76.11, 509.67);
    
    return quad;
}

- (AGKQuad)quadForPurpleFill
{
    // These points are the four corners of the sub quadrilateral that we want
    // to perspective correct. They could be gathered by dragging control points
    // to those corners like in the "Quad Controls" example.
    AGKQuad quad;
    quad.tl = CGPointMake(632.15, 196.54);
    quad.tr = CGPointMake(903.2, 184.89);
    quad.br = CGPointMake(996.01, 439.05);
    quad.bl = CGPointMake(542.13, 453.15);
    
    return quad;
}

@end
