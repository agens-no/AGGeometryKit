//
//  AngleConverter.swift
//  AGGeometryKit
//
//  Created by Håvard Fossli on 21/07/15.
//  Copyright (c) 2015 H√•vard Fossli. All rights reserved.
//

import Foundation
import UIKit
import Darwin

let π:CGFloat = CGFloat(M_PI)

class AngleConverterExample: UIViewController {
    
    @IBOutlet var sliderA:UISlider?
    @IBOutlet var sliderB:UISlider?
    @IBOutlet var viewA:UIView?
    @IBOutlet var viewB:UIView?
    @IBOutlet var textLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAngleOfViewA()
        updateAngleOfViewB()
        updateTextLabel()
    }
    
    @IBAction func viewASliderValueChanged(sender: UISlider) {
        updateAngleOfViewA()
        updateTextLabel()
    }
    
    @IBAction func viewBSliderValueChanged(sender: UISlider) {
        updateAngleOfViewB()
        updateTextLabel()
    }
    
    private func updateAngleOfViewA() {
        let angle = CGFloat(sliderA!.value)
        viewA?.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func updateAngleOfViewB() {
        let angle = CGFloat(sliderB!.value)
        viewB?.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func updateTextLabel() {
        textLabel?.text = textForLabel()
    }
    
    private func textForLabel() -> String {
        let radians:CGFloat = viewA!.convertAngleOfViewInRelationToView(viewB!)
        let degrees:CGFloat = radians * 180.0 / π
        let radiansString = String(format: "%.2f", radians)
        let degreesString = String(format: "%.0f", degrees)
        return "Angle between views is \(degreesString) degrees (\(radiansString) radians)"
    }
}
