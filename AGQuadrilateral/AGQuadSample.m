//
//  AGQuadSample.m
//  AGQuad
//
//  Created by Håvard Fossli on 18.01.13.
//  Copyright 2013 Håvard Fossli. All rights reserved.
//

#import "AGQuadSample.h"
#import "AGQuad.h"
#import "easing.h"
#import "CALayer+AGQuad.h"

@interface AGQuadSample ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end


@implementation AGQuadSample

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
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape1:(id)sender
{
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    quad.tr.y += 125;
    quad.br.y -= 65;
    quad.bl.x -= 40;
    quad.tl.x += 40;
    [self animateToQuad:quad];
}

- (IBAction)changeToOddShape2:(id)sender
{
    AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
    quad.tr.y -= 125;
    quad.br.y += 65;
    quad.bl.x += 40;
    quad.tl.x -= 40;
    [self animateToQuad:quad];
}

#pragma mark - Convinience methods

- (void)animateToQuad:(AGQuad)quad
{
    NSLog(@"Animating from:\n    %@", NSStringFromAGQuad(self.imageView.layer.quadrilateral));
    NSLog(@"Animating to:\n    %@", NSStringFromAGQuad(quad));
    
    NSTimeInterval duration = 2.0;
        
    [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad
                                                 forNumberOfFrames:duration * 60
                                                          duration:duration
                                                             delay:0.0
                                                  progressFunction:^double(double p) {
                                                      return ElasticEaseOut(p);
                                                  }
                                                            forKey:@"demo"
                                                        onComplete:^(BOOL finished) {
        NSString *quadInfoString = NSStringFromAGQuad([[self.imageView.layer presentationLayer] quadrilateral]);
        NSLog(@"Animation done (%@):\n    %@", finished ? @"FINISHED" : @"CANCELLED", quadInfoString);
    }];
}

@end
