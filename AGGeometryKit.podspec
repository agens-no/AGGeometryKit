Pod::Spec.new do |s|
    s.name         = "AGGeometryKit"
    s.version      = "1.2.4"
    s.summary      = "Quadrilaterals on CALayer, CGGeometry-functions, UIView/CALayer properties and other invaluable tools."
    s.homepage     = "https://github.com/hfossli/AGGeometryKit"
    s.license      = 'MIT'
    s.platform      = :ios, '5.0'
    s.requires_arc  = true
    s.authors      = {
    	"Håvard Fossli" => "hfossli@agens.no",
    	"Logan Holmes"  => "snown27@gmail.com",
      "Jørund Almås"  => "jalmaas@agens.no",
    	"Marcus Eckert" => "marcuseckert@gmail.com"
    	}
    s.source       = {
        :git => "https://github.com/hfossli/AGGeometryKit.git",
        :tag => s.version.to_s
        }

    s.frameworks    = 'CoreGraphics', 'UIKit', 'QuartzCore'
    s.source_files  = 'AGGeometryKit/**/*.{h,m}'

    # Some users of this library prefers to only use this subspec
    s.subspec 'UIViewProperties' do |ss|
        ss.frameworks    = 'CoreGraphics', 'UIKit', 'QuartzCore'
        ss.source_files  = 'AGGeometryKit/**/UIView+AGK+Properties.{h,m}'
    end

    # Some users of this library prefers to only use this subspec
    s.subspec 'CALayerProperties' do |ss|
        ss.frameworks    = 'CoreGraphics', 'QuartzCore'
        ss.source_files  = 'AGGeometryKit/**/CALayer+AGK+Properties.{h,m}'
    end
end
