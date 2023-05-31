//
//  BlurViewModifier.swift
//  
//
//  Created by Don Malte on 31.05.23.
//

import SwiftUI

struct BlurViewModifier: ViewModifier {
    
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {        
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    func blurStyle(cornerRadius: CGFloat) -> some View {
        modifier(BlurViewModifier(cornerRadius: cornerRadius))
    }
}
