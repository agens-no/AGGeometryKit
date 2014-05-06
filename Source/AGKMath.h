//
// Authors:
// Håvard Fossli <hfossli@agens.no>
// Marcus Eckert <marcuseckert@gmail.com>
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

inline CGFloat AGKInterpolate(CGFloat startValue, CGFloat endValue, CGFloat progress);
inline CGFloat AGKRemapToZeroOne(CGFloat value, CGFloat startValue, CGFloat endValue);
inline CGFloat AGKRemap(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue);
inline CGFloat AGKRemapAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue, CGFloat newStartValue, CGFloat newEndValue);
inline CGFloat AGKRemapToZeroOneAndClamp(CGFloat value, CGFloat oldStartValue, CGFloat oldEndValue);
inline CGFloat AGKClamp(CGFloat value, CGFloat min, CGFloat max);
inline BOOL AGKIsWithin(CGFloat value, CGFloat min, CGFloat max);
inline CGFloat AGKRadiansToDegrees(CGFloat radians);
inline CGFloat AGKDegreesToRadians(CGFloat degrees);
inline CGFloat AGKMakeProgressPingPong(CGFloat progress);
inline CGFloat AGKMakeProgressPingPongSin(CGFloat progress);
inline CGFloat AGKBezierYForX(CGFloat x, CGPoint p0, CGPoint p1, CGPoint p2, CGPoint p3);
inline CGFloat AGKBezierZeroOneYForX(CGFloat x, CGPoint p1, CGPoint p2);
inline CGFloat AGKEaseInWithBezier(CGFloat progress);
inline CGFloat AGKEaseOutWithBezier(CGFloat progress);
inline CGFloat AGKEaseInOutWithBezier(CGFloat progress, CGFloat force);
inline CGFloat AGKEaseOutWithOverShoot(CGFloat progress, CGFloat overshoot);
inline CGFloat AGKEaseOutWithPower(CGFloat progress, CGFloat power);

inline CGFloat AGKDelayedProgressForItems(NSUInteger index,
                                         NSUInteger itemCount,
                                         CGFloat overlap,
                                         CGFloat overallProgress);

inline CGFloat AGKEaseWithTwoBeziers(CGPoint tangent1,
                                    CGPoint tangent2,
                                    CGPoint pointOfConnection,
                                    CGFloat x,
                                    CGPoint tangent4,
                                    CGFloat time,
                                    CGFloat progress);

inline CGFloat AGKMinInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index);
inline CGFloat AGKMaxInArray(CGFloat values[], NSUInteger numberOfValues, NSUInteger *out_index);

inline double floatToDoubleZeroFill(float value);
