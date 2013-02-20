#import <Foundation/Foundation.h>
#import "AGPoint.h"

/*
 
 NOTE: When using this the layers anchorPoint must be set to {0, 0}.
 
 
 */

typedef union AGQuadrilateral {
    struct { AGPoint tl, tr, br, bl; };
    AGPoint v[4];
} AGQuadrilateral;

extern const AGQuadrilateral AGQuadrilateralZero;
inline BOOL AGQuadrilateralEqual(AGQuadrilateral q1, AGQuadrilateral q2);
inline BOOL AGQuadrilateralIsConvex(AGQuadrilateral q);
inline BOOL AGQuadrilateralIsValid(AGQuadrilateral q);
inline AGQuadrilateral AGQuadrilateralMove(AGQuadrilateral q, double x, double y);
inline AGQuadrilateral AGQuadrilateralInsetLeft(AGQuadrilateral q, double inset);
inline AGQuadrilateral AGQuadrilateralInsetRight(AGQuadrilateral q, double inset);
inline AGQuadrilateral AGQuadrilateralInsetTop(AGQuadrilateral q, double inset);
inline AGQuadrilateral AGQuadrilateralInsetBottom(AGQuadrilateral q, double inset);
inline AGQuadrilateral AGQuadrilateralMirror(AGQuadrilateral q, BOOL x, BOOL y);
inline AGQuadrilateral AGQuadrilateralMakeWithPoints(AGPoint tl, AGPoint tr, AGPoint br, AGPoint bl);
inline AGQuadrilateral AGQuadrilateralMakeWithCGPoints(CGPoint tl, CGPoint tr, CGPoint br, CGPoint bl);
inline AGQuadrilateral AGQuadrilateralMakeWithCGRect(CGRect rect);
inline AGQuadrilateral AGQuadrilateralMakeWithCGSize(CGSize size);
inline double AGQuadrilateralGetSmallestX(AGQuadrilateral q);
inline double AGQuadrilateralGetBiggestX(AGQuadrilateral q);
inline double AGQuadrilateralGetSmallestY(AGQuadrilateral q);
inline double AGQuadrilateralGetBiggestY(AGQuadrilateral q);
inline CGRect AGQuadrilateralGetBoundingRect(AGQuadrilateral q);
inline AGPoint AGQuadrilateralGetCenter(AGQuadrilateral q);
inline CGSize AGQuadrilateralGetSize(AGQuadrilateral q);
void AGQuadrilateralGetXValues(AGQuadrilateral q, double *out_values);
void AGQuadrilateralGetYValues(AGQuadrilateral q, double *out_values);
inline AGQuadrilateral AGQuadrilateralInterpolation(AGQuadrilateral q1, AGQuadrilateral q2, double progress);
inline NSString * NSStringFromAGQuadrilateral(AGQuadrilateral q);

/**
 * @discussion
 *   It is only possible to make 'convex quadrilateral' with transforms.
 *   So make sure your quadrilateral is convex.
 *   http://upload.wikimedia.org/wikipedia/commons/f/f1/Quadrilateral_hierarchy.png
 */
CATransform3D CATransform3DMakeRectToQuadrilateral(CGRect rect, AGQuadrilateral q);



@interface NSValue (AGQuadrilateralAdditions)

+ (NSValue *)valueWithAGQuadrilateral:(AGQuadrilateral)q;
- (AGQuadrilateral)AGQuadrilateralValue;

@end


