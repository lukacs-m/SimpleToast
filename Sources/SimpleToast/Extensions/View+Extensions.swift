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
                   onTap: (() -> ())? = nil,
                   completion: (() -> ())? = nil) -> some View {
            modifier(SimpleToastModifier(toast: toast,
                                         tapToDismiss: tapToDismiss,
                                         onTap: onTap,
                                         completion: completion))
        }
}

extension View {

    /// Applies the given text color, or keeps the inherited foreground style when `nil`.
    func textColor(_ color: Color? = nil) -> some View {
        foregroundStyle(color.map { AnyShapeStyle($0) } ?? AnyShapeStyle(.foreground))
    }
}
