//
//  View+Extensions.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

public extension View {

        /// Present `AlertToast`.
        /// - Parameters:
        ///   - toast: Binding<SimpleToast>
        /// - Returns: A toast
        func toast(toast: Binding<SimpleToast?>,
                   tapToDismiss: Bool = true,
                   offsetY: CGFloat = 0,
                   onTap: (() -> ())? = nil,
                   completion: (() -> ())? = nil) -> some View {
            modifier(SimpleToastModifier(toast: toast,
                                         tapToDismiss: tapToDismiss,
                                         offsetY: offsetY,
                                         onTap: onTap,
                                         completion: completion))
        }
}

extension View {
    /// Return some view w/o frame depends on the condition.
    /// This view modifier function is set by default to:
    /// - `maxWidth`: 175
    /// - `maxHeight`: 175
     func withFrame(_ withFrame: Bool) -> some View{
        modifier(FrameModifier(withFrame: withFrame))
    }

    /// Choose the alert background
    /// - Parameter color: Some Color, if `nil` return `VisualEffectBlur`
    /// - Returns: some View
     func toastBackground(_ color: Color? = nil) -> some View{
        modifier(BackgroundModifier(color: color))
    }

    /// Choose the alert background
    /// - Parameter color: Some Color, if `nil` return `.black`/`.white` depends on system theme
    /// - Returns: some View
     func textColor(_ color: Color? = nil) -> some View{
        modifier(TextForegroundModifier(color: color))
    }
}
