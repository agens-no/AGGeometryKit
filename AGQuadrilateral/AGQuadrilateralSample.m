//
//  AGQuadrilateralSample.m
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 18.01.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGQuadrilateralSample.h"
#import "AGQuadrilateral.h"
#import "easing.h"
#import "CALayer+AGQuadrilateral.h"

@interface AGQuadrilateralSample ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end


@implementation AGQuadrilateralSample

#pragma mark - Construct and destruct

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [self.imageView.layer ensureAnchorPointIsSetToZero];
    [super viewDidLoad];
}

- (void)dealloc
{
}

- (void)didReceiveMemoryWarning
{    
    [super didReceiveMemoryWarning];
}

#pragma mark - View events

- (IBAction)changeToSquareShape:(id)sender
{
    AGQuadrilateral quad = AGQuadrilateralMakeWithCGRect(self.imageView.bounds);
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape1:(id)sender
{
    AGQuadrilateral quad = AGQuadrilateralMakeWithCGRect(self.imageView.bounds);
    quad.tr.y += 125;
    quad.br.y -= 65;
    quad.bl.x -= 40;
    quad.tl.x += 40;
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape2:(id)sender
{
    AGQuadrilateral quad = AGQuadrilateralMakeWithCGRect(self.imageView.bounds);
    quad.tr.y -= 125;
    quad.br.y += 65;
    quad.bl.x += 40;
    quad.tl.x -= 40;
    [self animateToQuad:quad];
}

#pragma mark - Convinience methods

- (void)animateToQuad:(AGQuadrilateral)quad
{
    NSLog(@"Animating from:\n    %@", NSStringFromAGQuadrilateral(self.imageView.layer.quadrilateral));
    NSLog(@"Animating to:\n    %@", NSStringFromAGQuadrilateral(quad));
    
    NSTimeInterval duration = 2.0;
    
    [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad forNumberOfFrames:duration * 60 duration:duration delay:0.0 progressFunction:^double(double p) {
        return ElasticEaseOut(p);
    } forKey:@"demo" onComplete:^(BOOL finished) {
        NSLog(@"Presentation:\n    %@", NSStringFromAGQuadrilateral([[self.imageView.layer presentationLayer] quadrilateral]));
    }];
}

@end
