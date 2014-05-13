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

#import "AGKAngleConverterExample.h"
#import "UIView+AGK+AngleConverter.h"

@interface AGKAngleConverterExample ()

@property (nonatomic, strong) IBOutlet UISlider *sliderA;
@property (nonatomic, strong) IBOutlet UISlider *sliderB;
@property (nonatomic, strong) IBOutlet UILabel *calculatedAngleLabel;

@property (nonatomic, strong) IBOutlet UIImageView *viewA;
@property (nonatomic, retain) IBOutlet UIImageView *viewB;

@end

@implementation AGKAngleConverterExample

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    [self updateAngleOfViewA];
    [self updateAngleOfViewB];
    [self updateCalculationLabel];
}

- (IBAction)viewASliderValueChanged:(id)sender
{
    [self updateAngleOfViewA];
    [self updateCalculationLabel];
}

- (IBAction)viewBSliderValueChanged:(id)sender
{
    [self updateAngleOfViewB];
    [self updateCalculationLabel];
}

- (void)updateAngleOfViewA
{
    float transformationAngle = self.sliderA.value;
    float transformationAngleInRadians = transformationAngle * M_PI / 180.0f;
    self.viewA.transform = CGAffineTransformMakeRotation(transformationAngleInRadians); // rotates to the right
}

- (void)updateAngleOfViewB
{
    float transformationAngle = self.sliderB.value;
    float transformationAngleInRadians = transformationAngle * M_PI / 180.0f;
    self.viewB.transform = CGAffineTransformMakeRotation(transformationAngleInRadians); // rotates to the right
}

- (void)updateCalculationLabel
{
    float angle = [self.viewA convertAngleOfViewInRelationToView:self.viewB];
    self.calculatedAngleLabel.text = [NSString stringWithFormat:@"Calculated angle: %.2f", angle * 180.0f / M_PI];
}


@end
