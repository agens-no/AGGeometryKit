#AGGeometryKit


A bundle of small classes which enriches your possibilities with UIKit and CoreAnimation.

### Consists of

* Additions for CGGeometry for common CGRect, CGSize and CGPoint calculations
* AGQuad which helps you create CATransform3D from convex quadrilaterals (basically you can turn any rectangle into any convex four-cornered shape)
* Some usefull math functions
* Easing functions 
 

### Example code property 'quadrilateral' on CALayer

You can access `quadrilateral` as a property just like you would do with `frame`, `center` or `bounds`.

    AGQuad quad = self.imageView.layer.quadrilateral;
    NSLog(@"Quad: %@", NSStringFromAGQuad(quad));
    
    quad.br.x += 20;
    quad.br.y += 50;
    
    self.imageView.layer.quadrilateral = quad;

### Example video animation with AGQuad

[![ScreenShot](https://raw.github.com/hfossli/AGGeometryKit/master/AGGeometryKit/screenshot_youtube_XuzLhqe10u0.png)](http://www.youtube.com/watch?v=XuzLhqe10u0)


### Example code animation with AGQuad

    - (IBAction)animateToOtherShape:(id)sender
    {
        AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
        quad.tl.x -= 40; // top left
        quad.tr.y -= 125; // top right
        quad.br.y += 65; // bottom right
        quad.bl.x += 40; // bottom left
        [self animateToQuad:quad];
    }
    
    - (void)animateToQuad:(AGQuad)quad
    {        
        double (^interpolationFunction)(double) = ^(double p) {
            return (double) ElasticEaseOut(p);
        };
        
        [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad
                                                     forNumberOfFrames:2.0 * 60
                                                              duration:2.0
                                                                 delay:0.0
                                                               animKey:@"demo"
                                                 interpolationFunction:interpolationFunction
                                                            onComplete:nil];
    }


[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
