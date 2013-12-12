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

extern CGFloat agInterpolate(CGFloat startValue, CGFloat endValue, CGFloat progress)
{
    return startValue + ((endValue - startValue) * progress);
}

extern CGFloat agRemapToOneZero(CGFloat value, CGFloat startValue, CGFloat endValue)
{
    CGFloat diff = endValue - startValue;
    
    if(diff != 0.0f)
    {
        return (value - startValue) / diff;
    }
    else
    {
        return 0.0f;
    }
}

extern CGFloat agRemap(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue)
{
    float p = agRemapToOneZero(oldStartValue, oldEndValue, value);
    return agInterpolate(newStartValue, newEndValue, p);
}

extern CGFloat agRemapAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue)
{
    float p = agRemapToOneZero(oldStartValue, oldEndValue, value);
    float remapped = agInterpolate(newStartValue, newEndValue, p);
    return agClamp(remapped, newStartValue, newEndValue);
}

extern CGFloat agRemapToOneZeroAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue)
{
    float remapped = agRemapToOneZero(value, oldStartValue, oldEndValue);
    return agClamp(remapped, 0.0, 1.0);
}

extern CGFloat minInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index)
{
    CGFloat lowest = values[0];
    unsigned int index = 0;
    
    for(int i = 1; i < numberOfValues; i++)
    {
        CGFloat value = values[i];
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

extern CGFloat maxInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index)
{
    CGFloat highest = values[0];
    unsigned int index = 0;
    
    for(int i = 1; i < numberOfValues; i++)
    {
        CGFloat value = values[i];
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

extern CGFloat agClamp(CGFloat value, CGFloat min, CGFloat max)
{
    if(value > max)
        return max;
    if(value < min)
        return min;
    return value;
}

extern BOOL agIsWithin(CGFloat value, CGFloat min, CGFloat max)
{
    if(value >= max)
        return NO;
    if(value <= min)
        return NO;
    return YES;
}

extern CGFloat agRadiansToDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
}

extern CGFloat agDegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}
