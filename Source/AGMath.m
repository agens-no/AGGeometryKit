//
//  AGMath.m
//  VG
//
//  Created by Håvard Fossli on 24.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AGMath.h"

double valueInterpolate(double startValue, double endValue, double progress)
{
    double diff = endValue - startValue;
    return startValue + (diff * progress);
}

double valueInterpolateWithFunction(double startValue, double endValue, double progress, AHFloat (*function)(AHFloat))
{
    double diff = endValue - startValue;
    progress = function(progress);
    return startValue + (diff * progress);
}

double progressForValue(double startValue, double endValue, double value)
{
    double diff = value - startValue;
    double scope = endValue - startValue;
    double progress;
    
    if(diff != 0.0)
    {
        progress = diff / scope;
    }
    else
    {
        progress = 0.0f;
    }
    
    return progress;
}

double progressForValueConstrained(double startValue, double endValue, double value)
{
    return MIN(1.0, MAX(0.0, progressForValue(startValue, endValue, value)));
}

extern double doubleLowest(double values[], unsigned int numberOfValues)
{
    double lowest = values[0];
    
    for(int i = 1; i < numberOfValues; i++)
    {
        lowest = MIN(lowest, values[i]);
    }
    
    return lowest;
}

extern double doubleHighest(double values[], unsigned int numberOfValues)
{
    double highest = values[0];
    
    for(int i = 1; i < numberOfValues; i++)
    {
        highest = MAX(highest, values[i]);
    }
    
    return highest;
}

@interface AGMath ()

// private properties and methods

@end

@implementation AGMath

#pragma mark - Construct and destruct

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

@end
