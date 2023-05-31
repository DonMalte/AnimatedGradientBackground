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
    
    let duration: TimeInterval = 5
    
    init() {
        setPoints()
        startCycle()
    }
    
    private func startCycle() {
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
            animateGradient.toggle()
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    func setPoints() {
        invalidate()
        
        let topLeading = UnitPoint(x: 0.1, y: 0.2)
        let topTrailing = UnitPoint(x: 0.8, y: 0.1)
        let bottomLeading = UnitPoint(x: 0.1, y: 0.85)
        let bottomTrailing = UnitPoint(x: 0.7, y: 0.7)
        let leadingMiddle = UnitPoint(x: 0.2, y: 0.6)
        let trailingMiddle = UnitPoint(x: 0.9, y: 0.4)
        
        centerPoints = [topLeading, topTrailing, bottomLeading, bottomTrailing, leadingMiddle, trailingMiddle]
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(setNewPoint), userInfo: nil, repeats: true)
    }
    
    @objc func setNewPoint() {
        guard let newPoint = centerPoints.randomElement() else {
            return
        }
        
        // Dont use the same point twice
        if newPoint == centerUnitPoint {
            setNewPoint()
            return
        }
        
        withAnimation(.linear(duration: duration)) {
            centerUnitPoint = newPoint
        }
    }
}
