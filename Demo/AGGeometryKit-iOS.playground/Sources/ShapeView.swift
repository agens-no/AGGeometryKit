import UIKit

public class ShapeView : UIView {

    public var bezierPath : UIBezierPath? {
        didSet {
            self.shapeLayer.path = self.bezierPath?.CGPath
        }
    }
    var shapeLayer : CAShapeLayer! {
        get {
            return self.layer as! CAShapeLayer
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor(white: 0.9, alpha: 1.0).CGColor
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
}