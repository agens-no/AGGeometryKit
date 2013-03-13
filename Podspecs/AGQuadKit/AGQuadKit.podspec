Pod::Spec.new do |s|
    s.name         = "AGQuadKit"
    s.version      = "0.1.1"
    s.summary      = "AGQuadKit, a subset of AGGeometryKit, which helps you transform rectangles to convex four-cornered forms (convex quadrilaterals)."
    s.homepage     = "https://github.com/hfossli/AGGeometryKit.git"
    s.authors      = { "Håvard Fossli" => "hfossli@agens.no" }
    s.source       = { :git => "git@github.com:hfossli/AGGeometryKit.git", :tag => "0.1.1" }
    s.source_files = 'AGQuad.h', 'AGQuad.m', 'AGPoint.h', 'AGPoint.m', 'NSValue+AGQuad.h', 'NSValue+AGQuad.m', 'CALayer+AGQuad.h', 'CALayer+AGQuad.m', 'CAAnimationBlockDelegate.h', 'CAAnimationBlockDelegate.m'
    s.frameworks   = 'SystemConfiguration', 'IOKit', 'CoreGraphics', 'UIKit', 'QuartzCore'
    s.platform     = :ios
    s.requires_arc = true
end