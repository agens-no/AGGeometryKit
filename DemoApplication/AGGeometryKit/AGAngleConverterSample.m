//
// Author: Odd Magne Hågensen <oddmagne@agens.no>
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

#import "AGAngleConverterSample.h"
#import "UIView+AngleConverter.h"

@interface AGAngleConverterSample ()

@property (nonatomic, retain) UIImageView *viewA;
@property (nonatomic, retain) UIImageView *viewB;

@end

@implementation AGAngleConverterSample

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewA = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.viewA.backgroundColor = [UIColor colorWithRed:0.063 green:0.431 blue:0.996 alpha:1.000];
    self.viewA.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:self.viewA];
    
    self.viewB = [[UIImageView alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
    self.viewB.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.090 alpha:1.000];
    self.viewB.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:self.viewB];
    
    [self updateAngle];
    [self updateCalculationLabel];
}

- (IBAction)sliderValueChanged:(id)sender
{
    [self updateAngle];
    [self updateCalculationLabel];
}

- (void)updateAngle
{
    float transformationAngle = self.mySlider.value;
    float transformationAngleInRadians = transformationAngle * M_PI / 180.0f;
    self.viewB.transform = CGAffineTransformMakeRotation(transformationAngleInRadians); // rotates to the right
    
    self.inputLabel.text = [NSString stringWithFormat:@"Input angle: %.2f", transformationAngle];
}

- (void)updateCalculationLabel
{
    float angle = [self.viewA convertAngleOfViewInRelationToView:self.viewB];
    self.calculatedAngleLabel.text = [NSString stringWithFormat:@"Calculated angle: %.2f", angle * 180.0f / M_PI];
}


@end
