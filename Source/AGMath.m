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

extern double minInArray(double values[], unsigned int numberOfValues, unsigned int *out_index)
{
    double lowest = values[0];
    unsigned int index = 0;
    
    for(int i = 1; i < numberOfValues; i++)
    {
        double value = values[i];
        if(value < lowest)
        {
            lowest = value;
            index = i;
        }
    }
    
    if(out_index != NULL)
    {
        *out_index = index;
    }
    
    return lowest;
}

extern double maxInArray(double values[], unsigned int numberOfValues, unsigned int *out_index)
{
    double highest = values[0];
    unsigned int index = 0;
    
    for(int i = 1; i < numberOfValues; i++)
    {
        double value = values[i];
        if(value > highest)
        {
            highest = value;
            index = i;
        }
    }
    
    if(out_index != NULL)
    {
        *out_index = index;
    }
    
    return highest;
}

extern float clampf(float value, float min, float max)
{
    if(value > max)
        return max;
    if(value < min)
        return min;
    return value;
}

extern double clamp(double value, double min, double max)
{
    if(value > max)
        return max;
    if(value < min)
        return min;
    return value;
}

inline BOOL iswithinf(float value, float min, float max)
{
    if(value >= max)
        return NO;
    if(value <= min)
        return NO;
    return YES;
}

extern BOOL iswithin(double value, double min, double max)
{
    if(value >= max)
        return NO;
    if(value <= min)
        return NO;
    return YES;
}

extern double radiansToDegrees(double radians)
{
    return radians * 180 / M_PI;
}

extern double degreesToRadians(double degrees)
{
    return degrees * M_PI / 180;
}

extern double floatToDoubleZeroFill(float value)
{
    return [[NSString stringWithFormat:@"%f", value] doubleValue];
}