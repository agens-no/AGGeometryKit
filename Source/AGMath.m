//
// Author: Håvard Fossli <hfossli@agens.no>
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