Pod::Spec.new do |s|
    s.name         = "AGGeometryKit"
    s.version      = "1.0.4"
    s.summary      = "Quadrilaterals on CALayer, CGGeometry-functions, UIView/CALayer properties and other invaluable tools."
    s.homepage     = "https://github.com/hfossli/AGGeometryKit"
    s.license      = 'MIT'
    s.platform      = :ios, '5.0'
    s.requires_arc  = true
    s.authors      = { 
    	"Håvard Fossli" => "hfossli@agens.no",
    	"Marcus Eckert" => "marcuseckert@gmail.com",
    	"Logan Holmes"  => "snown27@gmail.com"
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
        ss.dependency      'AGAssert', '~> 0.2'
    end

    s.subspec 'Core' do |ss|
        ss.frameworks    = 'SystemConfiguration', 'IOKit', 'CoreGraphics', 'UIKit', 'QuartzCore'
        ss.source_files        = 'Source/**/*.{h,m}'
        ss.exclude_files       = 'Source/**/*Test.{h,m}'  
    end

    s.subspec 'FrameAccessor' do |ss|
        ss.source_files        = 'Source/Categories/UIView+AGK+Properties.{h,m}', 'Source/CoreGraphics_Extensions/CGGeometry+AGGeometryKit.{h,m}'
    end
end
