//
//  AGViewController.h
//  ViewAngleTest
//
//  Created by Odd Magne Hågensen on 31.01.13.
//  Copyright (c) 2013 Odd Magne Hågensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AngleConverterController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *mySlider;

- (IBAction)sliderValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *calculatedAngleLabel;

@end
