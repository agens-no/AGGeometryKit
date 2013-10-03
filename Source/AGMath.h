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

#import <Foundation/Foundation.h>

#define BIT_SET(x, b)   ((x) |= (b))
#define BIT_CLEAR(x, b) ((x) &= ~(b))
#define BIT_TEST_ANY(x, b)  (((x) & (b)) != 0)
#define BIT_TEST_ALL(x, b)  ({\
  __typeof__(x) __x = (x); \
  __typeof__(b) __b = (b);\
  (__x & __b) == __b;\
  })

#define CLAMP(x, low, high) ({\
  __typeof__(x) __x = (x); \
  __typeof__(low) __low = (low);\
  __typeof__(high) __high = (high);\
  __x > __high ? __high : (__x < __low ? __low : __x);\
  })

#define IS_WITHIN(x, low, high) ({\
  __typeof__(x) __x = (x); \
  __typeof__(low) __low = (low);\
  __typeof__(high) __high = (high);\
  __x <= __high && __x >= __low;\
  })

#define M_TAU       6.28318530717958647692528676655900576   /* tau                  */
#define M_TAU_2     M_PI                                    /* tau/2 = pi           */
#define M_TAU_4     M_PI_2                                  /* tau/4 = pi/2         */
#define M_1_TAU     0.15915494309189533576888376337251436   /* 1/tau = 1/2pi        */
#define M_2_TA      M_1_PI                                  /* 2/tau = 2/2pi = 1/pi */

inline float interpolatef(float startValue, float endValue, float progress);
inline double interpolate(double startValue, double endValue, double progress);

inline float interpolationProgressf(float startValue, float endValue, float value);
inline double interpolationProgress(double startValue, double endValue, double value);

inline double minInArray(double values[], unsigned int numberOfValues, unsigned int *out_index);
inline double maxInArray(double values[], unsigned int numberOfValues, unsigned int *out_index);

inline float clampf(float value, float min, float max);
inline double clamp(double value, double min, double max);

inline BOOL iswithinf(float value, float min, float max);
inline BOOL iswithin(double value, double min, double max);

inline double radiansToDegrees(double radians);
inline double degreesToRadians(double degrees);

inline double floatToDoubleZeroFill(float value);


