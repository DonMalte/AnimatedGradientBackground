//
//  AnimatedGradientViewModel.swift
//
//  Created by Don Malte on 31.05.23.
//

import SwiftUI

class AnimatedGradientViewModel: ObservableObject {
    
    @Published var centerUnitPoint: UnitPoint = .trailing
    @Published var animateGradient = false
    
    var centerPoints = [UnitPoint]()
    var timer: Timer?
        
    private let settings = AnimatedGradientSettings.shared
    
    init() {
        setPoints()
        startCycle()
    }
    
    private func startCycle() {
        withAnimation(.linear(duration: settings.animationDuration * 2).repeatForever(autoreverses: true)) {
            animateGradient.toggle()
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    func setPoints() {
        invalidate()
        
        centerPoints = settings.anchorPoints
        timer = Timer.scheduledTimer(timeInterval: settings.animationDuration, target: self, selector: #selector(setNewPoint), userInfo: nil, repeats: true)
    }
    
    @objc func setNewPoint() {
        guard let newPoint = centerPoints.randomElement() else {
            return
        }
        
        // We don't want to use the same point twice, as there would be no visible animation
        if newPoint == centerUnitPoint {
            setNewPoint()
            return
        }
        
        withAnimation(.linear(duration: settings.animationDuration)) {
            centerUnitPoint = newPoint
        }
    }
}
