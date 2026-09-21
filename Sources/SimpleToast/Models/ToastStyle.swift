//
//  ToastStyle.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

/// Customize Alert Appearance
public struct ToastDisplayStyle: Sendable {

    ///Get background color
    let backgroundColor: any ShapeStyle

    /// Get title color
    let titleColor: Color?

    /// Get subTitle color
    let subtitleColor: Color?

    /// Get title font
    let titleFont: Font

    /// Get subTitle font
    let subTitleFont: Font
    
    let shape: any Shape
    
    let offsetY: CGFloat

    public init(shape: any Shape,
                titleFont: Font = Font.body.bold(),
                subTitleFont: Font = Font.footnote,
                offsetY: CGFloat = 0,
                backgroundColor: any ShapeStyle = .regularMaterial,
                titleColor: Color? = nil,
                subtitleColor: Color? = nil) {
        self.shape = shape
        self.offsetY = offsetY
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.titleFont = titleFont
        self.subTitleFont = subTitleFont
    }
    
    public static var `default`: ToastDisplayStyle {
        ToastDisplayStyle(shape: .capsule)
    }
}
