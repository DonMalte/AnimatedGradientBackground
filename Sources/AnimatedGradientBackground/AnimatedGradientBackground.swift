//
//  AnimatedGradientBackground.swift
//
//  Created by Don Malte on 19.09.22.
//

import SwiftUI

/*
 I use two identical RadialGradients set with different colors (old and newly changed) and change the opacity of the gradient in the front to animate a color change. Not perfect but good enough.
 Got the idea from this blog: https://nerdyak.tech/development/2019/09/30/animating-gradients-swiftui.html
 */

public struct AnimatedGradientBackground: View {
    
    public init(backgroundColor: Color, accentColor: Color, settings: AnimatedGradientSettings = .shared) {
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        
        self.primaryAccentColor = accentColor
        self.primaryBackgroundColor = backgroundColor
        self.secondBackgroundColor = backgroundColor
        self.secondAccentColor = accentColor
        
        self.settings = settings
    }
    
    private var backgroundColor: Color
    private var accentColor: Color
    
    private var settings: AnimatedGradientSettings
    
    // Colors
    @State private var primaryBackgroundColor: Color
    @State private var primaryAccentColor: Color
    @State private var secondBackgroundColor: Color
    @State private var secondAccentColor: Color
    
    @State private var secondColorShown = true
        
    // ViewModel
    @StateObject var viewModel = AnimatedGradientViewModel()
    
    // Variables for rapid changes
    @State private var isColorChanging: Bool = false
    
    @State private var changedAccentColor: Color?
    @State private var changedBackgroundColor: Color?
    
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                let startRadius = viewModel.animateGradient ? geometry.size.width * 0.8 : geometry.size.height * 0.8
                
                // Secondary radial gradient
                RadialGradient(gradient: Gradient(colors: [
                        secondBackgroundColor,
                        secondAccentColor
                    ]),
                    center: viewModel.centerUnitPoint,
                    startRadius: startRadius, endRadius: 0)
                .ignoresSafeArea()
                
                // Primary radial gradiant
                RadialGradient(gradient: Gradient(colors: [
                        primaryBackgroundColor,
                        primaryAccentColor
                    ]),
                    center: viewModel.centerUnitPoint,
                    startRadius: startRadius, endRadius: 0)
                .ignoresSafeArea()
                .opacity(secondColorShown ? 0 : 1)
                .onChange(of: accentColor) { newColor in
                    DispatchQueue.main.async {
                        if isColorChanging {
                            changedAccentColor = newColor
                        } else {
                            initateAccentColorChange(newColor)
                        }
                    }
                }
                .onChange(of: backgroundColor) { newColor in
                    DispatchQueue.main.async {
                        if isColorChanging {
                            changedBackgroundColor = newColor
                        } else {
                            initateBackgroundColorChange(newColor)
                        }
                    }
                }
                .onDisappear {
                    viewModel.invalidate()
                }
                
                if settings.showBlurOverlay {
                    Rectangle()
                        .foregroundColor(.clear)
                        .blurStyle(cornerRadius: 0)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

// This part is necessary for rapid color changes - they wouldn't animate smoothly otherwise.
extension AnimatedGradientBackground {
    
    private func initateAccentColorChange(_ color: Color) {
        self.changedAccentColor = nil
        
        DispatchQueue.main.async {
            if secondColorShown {
                primaryAccentColor = color
            } else {
                secondAccentColor = color
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isColorChanging = true
            
            withAnimation(.linear(duration: 1)) {
                secondColorShown.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            colorChangeFinished()
        }
    }
    
    private func initateBackgroundColorChange(_ color: Color) {
        self.changedBackgroundColor = nil
        
        DispatchQueue.main.async {
            if secondColorShown {
                primaryBackgroundColor = color
            } else {
                secondBackgroundColor = color
            }
        }
    }
    
    private func colorChangeFinished() {
        isColorChanging = false
        
        if let changedAccentColor {
            initateAccentColorChange(changedAccentColor)
        }
        
        if let changedBackgroundColor {
            initateBackgroundColorChange(changedBackgroundColor)
        }
    }
}

struct AnimatedGradientBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        AnimatedGradientBackground(backgroundColor: .red, accentColor: .yellow)
    }
}
