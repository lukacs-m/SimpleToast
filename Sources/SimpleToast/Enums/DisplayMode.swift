//
//  DisplayMode.swift
//  
//
//  Created by Martin Lukacs on 08/07/2023.
//

import Foundation

/// Determine how the toast will be displayed
public enum DisplayMode: Equatable {

    ///Present at the center of the screen
    case center

    ///Drop from the top of the screen
    case top

    ///Banner from the bottom of the view
    case bottom(_ transition: BottomAnimation)
}
