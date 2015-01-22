Pod::Spec.new do |s|
    s.name         = "AGGeometryKit"
    s.version      = "1.1"
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

    s.default_subspec = 'Default'

    s.subspec 'Default' do |ss|
        ss.dependency      'AGGeometryKit/Core'
        ss.dependency      'AGGeometryKit/Dependencies'
    end

    s.subspec 'Dependencies' do |ss|
        ss.dependency      'JRSwizzle', '~> 1.0'
        ss.dependency      'AGAssert', '~> 1.0'
    end

    s.subspec 'Core' do |ss|
        ss.frameworks    = 'SystemConfiguration', 'CoreGraphics', 'UIKit', 'QuartzCore'
        ss.source_files  = 'Source/**/*.{h,m}'
        ss.exclude_files = 'Source/**/*Test.{h,m}'
    end

    s.subspec 'UIViewProperties' do |ss|
        ss.frameworks    = 'CoreGraphics', 'UIKit', 'QuartzCore'
        ss.source_files  = 'Source/**/UIView+AGK+Properties.{h,m}'
    end

    s.subspec 'CALayerProperties' do |ss|
        ss.frameworks    = 'CoreGraphics', 'QuartzCore'
        ss.source_files  = 'Source/**/CALayer+AGK+Properties.{h,m}'
    end
end
