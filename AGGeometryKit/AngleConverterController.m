//
//  AGViewController.m
//  ViewAngleTest
//
//  Created by Odd Magne Hågensen on 31.01.13.
//  Copyright (c) 2013 Odd Magne Hågensen. All rights reserved.
//

#import "AngleConverterController.h"
#import "UIView+AngleConverter.h"

@interface AngleConverterController ()

@property (nonatomic, retain) UIView *viewA;
@property (nonatomic, retain) UIView *viewB;

@end

@implementation AngleConverterController


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
    self.viewA.backgroundColor = [UIColor redColor];
    UIView *viewA2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    viewA2.backgroundColor = [UIColor greenColor];
    [self.viewA addSubview:viewA2];
    [self.view addSubview:self.viewA];
    
    self.viewB = [[UIView alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
    self.viewB.backgroundColor = [UIColor blueColor];
    UIView *viewB2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    viewB2.backgroundColor = [UIColor greenColor];
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
