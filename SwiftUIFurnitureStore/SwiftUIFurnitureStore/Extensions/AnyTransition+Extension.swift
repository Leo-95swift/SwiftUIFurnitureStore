//
//  AnyTransition+Extension.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 13.05.24.
//

import SwiftUI

/// Расширение для добавления функциональности transitions
extension AnyTransition {
    static var zoomAsymInOut: AnyTransition {
        .asymmetric(insertion: .scale(
            scale: 0.1,
            anchor: .topLeading
        )
            .combined(with: .offset(y: 120)), removal: .scale(scale: 0.2)
            .combined(with: .opacity))
    }
}
