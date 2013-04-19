//
//  AGQuadCrop.m
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.03.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGQuadCrop.h"
#import "AGQuadKit.h"
#import "JAValueToString.h"

@interface AGQuadCrop ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView1;
@property (nonatomic, strong) IBOutlet UIImageView *imageView2;

@end


@implementation AGQuadCrop

#pragma mark - Construct and destruct

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        
    }
    return self;
}

#undef JA_ENCODE
#define JA_ENCODE(val) ({\
    __typeof__(val) _val = val;\
    JAValueToString(@encode(typeof(_val)), (typeof(_val) *){ &(_val) }, sizeof _val);\
})

- (void)log
{
    NSLog(@"Frame: %@\nBounds: %@\nTransform: %@\nQuad: %@", NSStringFromCGRect(self.imageView1.frame), NSStringFromCGRect(self.imageView1.bounds), JA_ENCODE(self.imageView1.layer.transform), NSStringFromAGQuad(self.imageView1.layer.quadrilateral));
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    [self.imageView1.layer ensureAnchorPointIsSetToZero];
    
    //self.imageView1.frame = (CGRect){CGPointZero, self.imageView1.image.size};
    
    CGRect originalBounds = self.imageView1.bounds;
    
    UIImage *image = self.imageView1.image;
    
    AGQuad q1 = AGQuadMakeWithCGRect(self.imageView1.bounds);
    AGQuad q2 = AGQuadMakeWithCGRect(self.imageView1.bounds);
    q2.tl = AGPointMake(332, 49);
    q2.tr = AGPointMake(475, 67);
    q2.br = AGPointMake(479, 270);
    q2.bl = AGPointMake(336, 265);
    AGQuad q3 = AGQuadInterpolation(q1, q2, 0.5);
    
    CATransform3D t1 = CATransform3DWithQuadFromBounds(q2, self.imageView1.bounds);
    CATransform3D t2 = CATransform3DConcat(t1, t1);
    CATransform3D t3 = CATransform3DInvert(t2);
    
    
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = self.imageView1.frame;
    maskView.layer.shadowPath = [UIBezierPath bezierPathWithAGQuad:q2].CGPath;
    maskView.layer.shadowColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    maskView.layer.shadowOpacity = 1.0;
    maskView.layer.shadowRadius = 0.0;
    maskView.layer.shadowOffset = CGSizeZero;
    maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [self.imageView1.superview addSubview:maskView];
    
    JA_DUMP(maskView.layer.transform);
    maskView.layer.transform = t1;
    JA_DUMP(maskView.layer.transform);
    maskView.layer.transform = CATransform3DInvert(t1);
    JA_DUMP(maskView.layer.transform);
    maskView.layer.transform = CATransform3DConcat(t1, CATransform3DInvert(t1));
    JA_DUMP(maskView.layer.transform);
    maskView.layer.transform = CATransform3DConcat(CATransform3DInvert(t1), CATransform3DInvert(t1));
    JA_DUMP(maskView.layer.transform);
    
    CGRect newFrame = self.imageView1.frame;
    
//    self.imageView1.layer.quadrilateral = q2;

//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        self.imageView1.layer.quadrilateral = q4;
//        [self.imageView1.layer animateFromPresentedStateToQuadrilateral:q4
//                                                      forNumberOfFrames:2.0 * 60.0
//                                                               duration:2.0
//                                                                  delay:0.0
//                                                                animKey:@"demo"
//                                                  interpolationFunction:^(double p) {
//                                                      return p;
//                                                  }
//                                                             onComplete:nil];
//    });
    
//    assert(AGQuadIsValid(q2));
//
    self.imageView2.image = [image cropToQuad:q2 outputSize:self.imageView2.bounds.size];
//    
//    self.imageView1.layer.transform = CATransform3DWithQuadFromBounds(q4, self.imageView1.bounds);
}

- (void)dealloc
{
}

- (void)didReceiveMemoryWarning
{    
    [super didReceiveMemoryWarning];
}

#pragma mark - View events


#pragma mark - Convinience methods

@end
