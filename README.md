#AGGeometryKit


A bundle of small classes which enriches your possibilities with UIKit and CoreAnimation.

### Consists of

* Additions for CGGeometry for common CGRect, CGSize and CGPoint calculations
* AGQuad which helps you create CATransform3D from convex quadrilaterals
* Some usefull math functions
* Easing functions 

### Pod spec full kit

	Pod::Spec.new do |s|
	  s.name         = "AGGeometryKit"
	  s.version      = "1.0"
	  s.summary      = "A bundle of small classes which enriches your possibilities with UIKit and CoreAnimation."
	  s.homepage     = "https://github.com/hfossli/AGGeometryKit.git"
	  s.authors      = { "Håvard Fossli" => "hfossli@agens.no" }
	  s.source       = { :git => "git@github.com:hfossli/AGGeometryKit.git", :branch => "master" }
	  s.source_files = FileList['Source/*'].exclude(/.*Test\.[hm]$/)
	  s.frameworks   = 'SystemConfiguration', 'IOKit', 'CoreGraphics', 'UIKit', 'QuartzCore'
	  s.platform     = :ios
	end

### Pod spec AGQuad exclusive (Quadrilaterals)

	Pod::Spec.new do |s|
	  s.name         = "AGQuadrilaterals"
	  s.version      = "1.0"
	  s.summary      = "A bundle of small classes which enriches your possibilities with UIKit and CoreAnimation."
	  s.homepage     = "https://github.com/hfossli/AGGeometryKit.git"
	  s.authors      = { "Håvard Fossli" => "hfossli@agens.no" }
	  s.source       = { :git => "git@github.com:hfossli/AGGeometryKit.git", :branch => "master" }
	  s.source_files = 'AGQuad.h', 'AGQuad.m', 'AGPoint.h', 'AGPoint.m', 'NSValue+AGQuad.h', 'NSValue+AGQuad.m', 'CALayer+AGQuad.h', 'CALayer+AGQuad.m', 'CAAnimationBlockDelegate.h', 'CAAnimationBlockDelegate.m'
	  s.frameworks   = 'SystemConfiguration', 'IOKit', 'CoreGraphics', 'UIKit', 'QuartzCore'
	  s.platform     = :ios
	end