//
//  AGMath.h
//  VG
//
//  Created by Håvard Fossli on 24.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "easing.h"

double valueInterpolate(double startValue, double endValue, double progress);
double valueInterpolateWithFunction(double startValue, double endValue, double progress, AHFloat (*function)(AHFloat));
double progressForValue(double startValue, double endValue, double value);
double progressForValueConstrained(double startValue, double endValue, double value);
inline double doubleLowest(double values[], unsigned int numberOfValues);
inline double doubleHighest(double values[], unsigned int numberOfValues);


@interface AGMath : NSObject {}

@end
