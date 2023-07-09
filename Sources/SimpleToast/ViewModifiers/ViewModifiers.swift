//
//  ViewModifiers.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

///View Modifier for dynamic frame when alert type is `.regular` / `.loading`
struct FrameModifier: ViewModifier {
    let withFrame: Bool
    let maxWidth: CGFloat = 175
    let maxHeight: CGFloat = 175

    @ViewBuilder
    func body(content: Content) -> some View {
        if withFrame {
            content
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .center)
        } else {
            content
        }
    }
}

///View Modifier to change the alert background
struct BackgroundModifier: ViewModifier {

    let color: Color?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let color {
            content
                .background(color)
        } else {
            content
                .background(.regularMaterial)
        }
    }
}

//View Modifier to change the text colors
struct TextForegroundModifier: ViewModifier{
    let color: Color?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let color {
            content
                .foregroundColor(color)
        } else {
            content
        }
    }
}
