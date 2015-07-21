import QuartzCore

public func NSStringFromCATransform3D(t: CATransform3D) -> NSString {
    return NSString(format: ("\nm11:%f, m12:%f, m13:%f, m14:%f,\nm21:%f, m22:%f, m23:%f, m24:%f,\nm31:%f, m32:%f, m33:%f, m34:%f,\nm41:%f, m42:%f, m43:%f, m44:%f)\n" as NSString),
        t.m11, t.m12, t.m13, t.m14,
        t.m21, t.m22, t.m23, t.m24,
        t.m31, t.m32, t.m33, t.m34,
        t.m41, t.m42, t.m43, t.m44
    )
}