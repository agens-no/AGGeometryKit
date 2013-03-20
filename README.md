#AGGeometryKit

Create CATransform3D with quadrilaterals, useful math functions, calculate angle between views ++

### Consists of

* Additions for CGGeometry for common CGRect, CGSize and CGPoint calculations
* AGQuad which helps you create CATransform3D from convex quadrilaterals (basically you can turn any rectangle into any convex four-cornered shape)
* Some useful math functions

More about quadrilaterals: http://en.wikipedia.org/wiki/Quadrilateral

**Keywords**: Convex quadrilateral, simple quadrilateral, tangential, kite, rhombus, square, trapezium, trapezoid, parallelogram, bicentric, cyclic


What can you do with it?
------

I'm most curious myself about this part. You can use the quadrilateral on any view, even webviews with just as good performance as you would have not using it. 
Send me mail or twitter me anytime if you want to discuss possibilities and things you try to acheive. :)

Bartosz Ciechanowski created a ![genie effect](https://github.com/Ciechan/BCGenieEffect/) around desember 2012 which derives from a fraction of the code found here.


Example video animation with AGQuad
------

[![ScreenShot](https://raw.github.com/hfossli/AGGeometryKit/master/AGGeometryKit/screenshot_youtube_XuzLhqe10u0.png)](http://www.youtube.com/watch?v=XuzLhqe10u0)


Example code property 'quadrilateral' on CALayer
------

You can access `quadrilateral` as a property just like you would do with `frame`, `center` or `bounds`.

    AGQuad quad = self.imageView.layer.quadrilateral;
    NSLog(@"Quad: %@", NSStringFromAGQuad(quad));
    
    quad.br.x += 20; // bottom right x
    quad.br.y += 50; // bottom right y
    
    self.imageView.layer.quadrilateral = quad;
    
It acts very similar to how `frame` relates to `center`, `transform` and `bounds`. In other words always reflects current presented state. With no transform as identity the quadrilateral returned will be the quadrilateral for `bounds`.

Example code animation with AGQuad
------

    - (IBAction)animateToOtherShape:(id)sender
    {
        AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
        quad.tl.x -= 40; // top left x
        quad.tr.y -= 125; // top right y
        quad.br.y += 65; // bottom right y
        quad.bl.x += 40; // bottom left x
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

Standard CoreAnimation-animation using CATransform3D with custom interpolation between quad points.


Debugging
------

These things usually tend to mess up
- autoresizing mask (to be 100% sure it is good for debugging to turn off `autoresizesSubviews`)
- anchorPoint MUST be {0, 0} always when using quadrilaterals

I sometimes create a view to represent the quadrilateral if I'm having issues getting the right quadrilateral.

    UIView *quadPreview = [[UIView alloc] init];
    quadPreview.frame = quadView.frame;
    quadPreview.layer.shadowPath = [UIBezierPath bezierPathWithAGQuad:quad].CGPath;
    quadPreview.layer.shadowColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    quadPreview.layer.shadowOpacity = 1.0;
    quadPreview.layer.shadowRadius = 0.0;
    quadPreview.layer.shadowOffset = CGSizeZero;
    quadPreview.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [quadView.superview addSubview:quadPreview];

Cocoa pods
-------
    
It is added to the Cocoa Pods public repository as `AGGeometryKit`.    

[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
