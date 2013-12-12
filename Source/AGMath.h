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

#define AG_CLAMP(x, low, high) ({\
  __typeof__(x) __x = (x); \
  __typeof__(low) __low = (low);\
  __typeof__(high) __high = (high);\
  __x > __high ? __high : (__x < __low ? __low : __x);\
  })

#define AG_IS_WITHIN(x, low, high) ({\
  __typeof__(x) __x = (x); \
  __typeof__(low) __low = (low);\
  __typeof__(high) __high = (high);\
  __x <= __high && __x >= __low;\
  })



//#define AG_M_TAU       6.28318530717958647692528676655900576   /* tau                  */
//#define AG_M_TAU_2     M_PI                                    /* tau/2 = pi           */
//#define AG_M_TAU_4     M_PI_2                                  /* tau/4 = pi/2         */
//#define AG_M_1_TAU     0.15915494309189533576888376337251436   /* 1/tau = 1/2pi        */
//#define AG_M_2_TA      M_1_PI                                  /* 2/tau = 2/2pi = 1/pi */


inline CGFloat agInterpolate(CGFloat startValue, CGFloat endValue, CGFloat progress);

inline CGFloat agRemapToZeroOne(CGFloat value, CGFloat startValue, CGFloat endValue);
inline CGFloat agRemap(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue);
inline CGFloat agRemapAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue);
inline CGFloat agRemapToZeroOneAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue);

inline CGFloat agClamp(CGFloat value, CGFloat min, CGFloat max);

inline BOOL agIsWithin(CGFloat value, CGFloat min, CGFloat max);

inline CGFloat agRadiansToDegrees(CGFloat radians);
inline CGFloat agDegreesToRadians(CGFloat degrees);
inline CGFloat agMakeProgressPingPong(CGFloat progress);
inline CGFloat agMakeProgressPingPongSin(CGFloat progress);
inline CGFloat agBezierYForX(CGFloat x, CGPoint p0, CGPoint p1, CGPoint p2, CGPoint p3);
inline CGFloat agBezierZeroOneYForX(CGFloat x, CGPoint p1, CGPoint p2);
inline CGFloat agEaseInWithBezier(CGFloat progress);
inline CGFloat agEaseOutWithBezier(CGFloat progress);
inline CGFloat agEaseInOutWithBezier(CGFloat progress, CGFloat force);
inline CGFloat agEaseOutWithOverShoot(CGFloat progress, CGFloat overshoot);
inline CGFloat agEaseOutWithPower(CGFloat progress, CGFloat power);

inline CGFloat agDelayedProgressForItems(NSUInteger index,
                                         NSUInteger itemCount,
                                         CGFloat overlap,
                                         CGFloat overallProgress);

inline CGFloat agEaseWithTwoBeziers(CGPoint tangent1,
                                    CGPoint tangent2,
                                    CGPoint pointOfConnection,
                                    CGFloat x,
                                    CGPoint tangent4,
                                    CGFloat time,
                                    CGFloat progress);

inline CGFloat agMinInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index);
inline CGFloat agMaxInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index);

