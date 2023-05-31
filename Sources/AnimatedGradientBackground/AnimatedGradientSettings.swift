//
//  AnimatedGradientSettings.swift
//
//  Created by Don Malte on 31.05.23.
//

import Foundation

public class AnimatedGradientSettings {
    
    static var shared = AnimatedGradientSettings()
    
    /// The time it takes for a radial gradient to float from one unit point to the next
    public var animationDuration: TimeInterval = 5
    
    /// Set this boolean to decide if there be a blur view on top of the animated gradient. Default is true.
    public var showBlurOverlay: Bool = true
    
    // More options like the areas of the gradient animation?
}
