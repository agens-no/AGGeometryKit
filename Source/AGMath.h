
//
//  AGMath.h
//  VG
//
//  Created by Håvard Fossli on 24.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BIT_SET(x, b)   ((x) |= (b))
#define BIT_CLEAR(x, b) ((x) &= ~(b))
#define BIT_TEST(x, b)  ((x) & (b))

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

inline double valueInterpolate(double startValue, double endValue, double progress);
inline double progressForValue(double startValue, double endValue, double value);

inline double minInArray(double values[], unsigned int numberOfValues, unsigned int *out_index);
inline double maxInArray(double values[], unsigned int numberOfValues, unsigned int *out_index);

inline float clampf(float value, float min, float max);
inline double clamp(double value, double min, double max);

inline BOOL iswithinf(float value, float min, float max);
inline BOOL iswithin(double value, double min, double max);

inline double radiansToDegrees(double radians);
inline double degreesToRadians(double degrees);

inline double floatToDoubleZeroFill(float value);


