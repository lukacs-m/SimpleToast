//
//  ToastStyle.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

/// Customize Alert Appearance
public struct ToastStyle: Equatable {

    ///Get background color
    let backgroundColor: Color?

    /// Get title color
    let titleColor: Color?

    /// Get subTitle color
    let subtitleColor: Color?

    /// Get border color
    let borderColor: Color?

    /// Get title font
    let titleFont: Font?

    /// Get subTitle font
    let subTitleFont: Font?

    public init(backgroundColor: Color? = nil,
                titleColor: Color? = nil,
                subtitleColor: Color? = nil,
                borderColor: Color? = nil,
                titleFont: Font? = nil,
                subTitleFont: Font? = nil) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.borderColor = borderColor
        self.titleFont = titleFont
        self.subTitleFont = subTitleFont
    }
}
