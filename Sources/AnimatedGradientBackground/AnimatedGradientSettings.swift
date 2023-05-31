//
//  AnimatedGradientSettings.swift
//
//  Created by Don Malte on 31.05.23.
//

import SwiftUI

public class AnimatedGradientSettings {
    
    static var shared = AnimatedGradientSettings()
    
    /// The time it takes for a radial gradient to float from one unit point to the next. Default is set to 5 seconds.
    public var animationDuration: TimeInterval = 5
    
    /// Set this boolean to decide if there be a blur view on top of the animated gradient. The default value is true.
    public var showBlurOverlay: Bool = true
    
    /// Declare the anchor points of the gradient view - So where should the gradient float to? The default value is set to a leading and trailing point for top, center and bottom each.
    public var anchorPoints: [UnitPoint] = [UnitPoint(x: 0.1, y: 0.2), UnitPoint(x: 0.8, y: 0.1), UnitPoint(x: 0.1, y: 0.85), UnitPoint(x: 0.7, y: 0.7), UnitPoint(x: 0.2, y: 0.6), UnitPoint(x: 0.9, y: 0.4)]
}
