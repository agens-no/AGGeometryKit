//
//  AGMath.m
//  VG
//
//  Created by Håvard Fossli on 24.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AGMath.h"

extern double valueInterpolate(double startValue, double endValue, double progress)
{
    double diff = endValue - startValue;
    double value = startValue + (diff * progress);
    return value;
}

extern double progressForValue(double startValue, double endValue, double value)
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

extern double minInArray(double values[], unsigned int numberOfValues)
{
    double lowest = values[0];
    
    for(int i = 1; i < numberOfValues; i++)
    {
        lowest = MIN(lowest, values[i]);
    }
    
    return lowest;
}

extern double maxInArray(double values[], unsigned int numberOfValues)
{
    double highest = values[0];
    
    for(int i = 1; i < numberOfValues; i++)
    {
        highest = MAX(highest, values[i]);
    }
    
    return highest;
}

extern double clamp(double value, double min, double max)
{
    if(value > max)
        return max;
    if(value < min)
        return min;
    return value;
}

extern double radiansToDegrees(double radians)
{
    return radians * 180 / M_PI;
}

extern double degreesToRadians(double degrees)
{
    return degrees * M_PI / 180;
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
