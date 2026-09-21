//
//  ToastType.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI

/// Determine what the toast will display
public enum ToastType: Sendable, Equatable, Identifiable, Hashable {
    
    ///Animated checkmark
    case complete(_ color: Color)

    ///Animated xmark
    case error(_ color: Color)

    case image(Image)

    ///Loading indicator (Circular)
    case loading

    ///Only text alert
    case regular
    
    public var id: String {
        switch self {
        case .complete:
            "complete"
        case .error:
            "error"
        case .image:
            "image"
        case .loading:
            "loading"
        case .regular:
            "regular"
        }
    }
    
    // Image is not Hashable, so .image hashes by case only. Equal values still hash equally.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        switch self {
        case .complete(let color), .error(let color):
            hasher.combine(color)
        case .image, .loading, .regular:
            break
        }
    }
}
