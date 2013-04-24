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

@property (nonatomic, retain) UIView *viewA;
@property (nonatomic, retain) UIView *viewB;

@end

@implementation AGAngleConverterSample


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"AngleConverter";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    self.viewA = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.viewA.backgroundColor = [UIColor colorWithRed:0.063 green:0.431 blue:0.816 alpha:1.000];
    UIView *viewA2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    viewA2.backgroundColor = [UIColor colorWithRed:0.490 green:0.812 blue:0.992 alpha:1.000];
    [self.viewA addSubview:viewA2];
    [self.view addSubview:self.viewA];
    
    self.viewB = [[UIView alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
    self.viewB.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.090 alpha:1.000];
    UIView *viewB2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    viewB2.backgroundColor = [UIColor colorWithRed:0.988 green:0.859 blue:0.753 alpha:1.000];
    [self.viewB addSubview:viewB2];
    [self.view addSubview:self.viewB];
    
    [self updateLabels];
}

- (IBAction)sliderValueChanged:(id)sender
{
    [self updateLabels];
}

- (void)updateLabels
{
    float transformationAngle = self.mySlider.value;
    float transformationAngleInRadians = transformationAngle * M_PI / 180.0f;
    self.viewB.transform = CGAffineTransformMakeRotation(transformationAngleInRadians); // rotates to the right
    
    self.inputLabel.text = [NSString stringWithFormat:@"Input angle: %.2f", transformationAngle];
    
    float angle = [self.viewA convertAngleOfViewInRelationToView:self.viewB];
    
    self.calculatedAngleLabel.text = [NSString stringWithFormat:@"Calculated angle: %.2f", angle * 180.0f / M_PI];
}


@end
