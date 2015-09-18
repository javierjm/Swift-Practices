//
//  VisualizerViewController.swift
//  Streamify
//
//  Created by Marin Todorov on 8/13/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class VisualizerViewController: UIViewController {

    var leftBar = CALayer()
    var rightBar = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        leftBar.cornerRadius = 2.0
        leftBar.backgroundColor = UIColor(red: 0.98, green: 0.69, blue: 0.37, alpha: 1.0).CGColor
        leftBar.frame = CGRect(x: 0, y: self.view.bounds.height / 2, width: self.view.bounds.width, height: 100)
        
        var leftDisplay = createDisplay(leftBar)
        leftDisplay.frame = view.bounds
        view.layer.addSublayer(leftDisplay)
    }
    
    func createDisplay (first: CALayer) -> CAReplicatorLayer {
        var display = CAReplicatorLayer()
        
        display.addSublayer(first)
        display.instanceTransform = CATransform3DMakeTranslation(12.0, 0.0, 0)
        display.instanceCount = Int(view.frame.size.width / 12)
        display.instanceDelay = 0.02
        return display
    }
    
    
    func updateLevels(left: Float, right: Float) {
        let leftScale = max (0.2, CGFloat(left) + 40) * 3
        let leftScaleAnimation = CABasicAnimation(keyPath: "trasnform.scale.y")
        leftScaleAnimation.toValue = leftScaleAnimation
        leftScaleAnimation.duration = 1.0
        leftBar.addAnimation(leftScaleAnimation, forKey: nil)
        
    }
}