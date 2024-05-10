//
//  ColorCircle.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import SwiftUI

/// информация о цветных кружках
struct ColorCircle {
    // название цвета
    let colorName: String
    // цвет шарика
    let color: Color
    /// идентификатор для цвета
    var id = UUID()
}
