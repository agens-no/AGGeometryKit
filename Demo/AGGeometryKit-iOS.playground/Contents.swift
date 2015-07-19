/*:
## AGGeometryKit Playground for iOS
Use AGGeometryKit.xcworkspace to run this playground so it can import AGGeometryKitiOS.framework
*/

import UIKit
import XCPlayground
import AGGeometryKitiOS

//: Loading up an image from `Resources` folder
let image = UIImage(named: "sample_image6@2x.jpg")!

let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
//: Creating target UIBezierPath/AGKQuad
let quad = AGKQuadMake(
    CGPointMake(142, 180),
    CGPointMake(960, 0),
    CGPointMake(960, 540),
    CGPointMake(0, 540))
let bezierPath = UIBezierPath(AGKQuad: quad)
let shapeView = ShapeView(frame: imageRect)
shapeView.bezierPath = bezierPath


//: Using CALayer's Quadrilateral
let imageView = UIImageView(frame: imageRect)
imageView.image = image
imageView.layer.ensureAnchorPointIsSetToZero()
imageView.layer.quadrilateral = quad
let view = UIView(frame: imageRect)
view.backgroundColor = UIColor.whiteColor()
view.addSubview(imageView)
XCPShowView("view", view: view)

//: Getting target transform
var transform3D = CATransform3DWithAGKQuadFromRect(quad, imageRect)

//: Rendering an image using specific transform
let transformedImage = image.imageWithTransform(transform3D, anchorPoint: CGPointZero)


