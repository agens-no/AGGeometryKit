//
//  QuadAnimationExample.swift
//  AGGeometryKit
//
//  Created by Håvard Fossli on 21/07/15.
//  Copyright (c) 2015 H√•vard Fossli. All rights reserved.
//

import Foundation
import UIKit
import AGGeometryKit

class QuadAnimationExample: UIViewController {
    
    @IBOutlet var imageView:UIImageView?
    var originalQuad:AGKQuad = AGKQuadZero
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let source = imageView {
            source.layer.ensureAnchorPointIsSetToZero()
            originalQuad = source.layer.quadrilateral
        }
    }
    
    @IBAction func changeToSquareShape() {
        animateToQuad(originalQuad)
    }
    
    @IBAction func changeToOddShape1() {
        var quad = originalQuad;
        quad.tr.y += 70;
        quad.tr.x -= 20;
        quad.br.x += 10;
        quad.br.y -= 30;
        quad.bl.x -= 40;
        quad.tl.x += 40;
        animateToQuad(quad)
    }
    
    @IBAction func changeToOddShape2() {
        var quad = self.originalQuad;
        quad.tr.y -= 125;
        quad.br.y += 65;
        quad.bl.x += 40;
        quad.tl.x -= 40;
        animateToQuad(quad)
    }
    
    @IBAction func tapRecognized(recognizer: UITapGestureRecognizer) {
        NSLog("Tap recognized. Logging just to show that we are receiving touch correctly even when animating.");
    }
    
    private func animateToQuad(quad: AGKQuad) {
        
        NSLog("Animating from: \(NSStringFromAGKQuad(imageView!.layer.quadrilateral))")
        NSLog("Animating to: \(NSStringFromAGKQuad(quad))")
        
        let duration:NSTimeInterval = 2.0
        
        let ease: (p: Double) -> Double = {
            return Double(ElasticEaseOut(Float($0)))
        }
        
        let onComplete: (completed: Bool) -> Void = {
            let state = $0 ? "FINISHED" : "CANCELLED"
            NSLog("Animation done \(state)")
        }
        
        imageView!.layer.animateFromPresentedStateToQuadrilateral(quad,
            forNumberOfFrames: UInt(duration * 60),
            duration: duration,
            delay: 0.0,
            animKey: "demo",
            easeFunction: ease,
            onComplete: onComplete
        )
    }
}
