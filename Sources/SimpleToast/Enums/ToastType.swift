//
//  ToastType.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

/// Determine what the toast will display
public enum ToastType: Equatable {

    ///Animated checkmark
    case complete(_ color: Color)

    ///Animated xmark
    case error(_ color: Color)

    ///System image from `SFSymbols`
    case systemImage(_ name: String, _ color: Color)

    ///Image from Assets
    case image(_ name: String, _ color: Color)

    ///Loading indicator (Circular)
    case loading

    ///Only text alert
    case regular
}
