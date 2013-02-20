#import <Foundation/Foundation.h>
#import "AGPoint.h"

typedef union AGQuad {
    struct { AGPoint tl, tr, br, bl; };
    AGPoint v[4];
} AGQuad;

extern const AGQuad AGQuadZero;
inline BOOL AGQuadEqual(AGQuad q1, AGQuad q2);
inline BOOL AGQuadIsConvex(AGQuad q);
inline BOOL AGQuadIsValid(AGQuad q);
inline AGQuad AGQuadMove(AGQuad q, double x, double y);
inline AGQuad AGQuadInsetLeft(AGQuad q, double inset);
inline AGQuad AGQuadInsetRight(AGQuad q, double inset);
inline AGQuad AGQuadInsetTop(AGQuad q, double inset);
inline AGQuad AGQuadInsetBottom(AGQuad q, double inset);
inline AGQuad AGQuadMirror(AGQuad q, BOOL x, BOOL y);
inline AGQuad AGQuadMake(AGPoint tl, AGPoint tr, AGPoint br, AGPoint bl);
inline AGQuad AGQuadMakeWithCGPoints(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl);
inline AGQuad AGQuadMakeWithCGRect(CGRect rect);
inline AGQuad AGQuadMakeWithCGSize(CGSize size);
inline double AGQuadGetSmallestX(AGQuad q);
inline double AGQuadGetBiggestX(AGQuad q);
inline double AGQuadGetSmallestY(AGQuad q);
inline double AGQuadGetBiggestY(AGQuad q);
inline CGRect AGQuadGetBoundingRect(AGQuad q);
inline AGPoint AGQuadGetCenter(AGQuad q);
inline CGSize AGQuadGetSize(AGQuad q);
void AGQuadGetXValues(AGQuad q, double *out_values);
void AGQuadGetYValues(AGQuad q, double *out_values);
inline AGQuad AGQuadInterpolation(AGQuad q1, AGQuad q2, double progress);
inline NSString * NSStringFromAGQuad(AGQuad q);

/**
 * @discussion
 *   It is only possible to make 'convex quadrilateral' with transforms.
 *   So make sure your quadrilateral is convex.
 *   http://upload.wikimedia.org/wikipedia/commons/f/f1/Quadrilateral_hierarchy.png
 */
CATransform3D CATransform3DForCGRectToQuad(CGRect rect, AGQuad q);


