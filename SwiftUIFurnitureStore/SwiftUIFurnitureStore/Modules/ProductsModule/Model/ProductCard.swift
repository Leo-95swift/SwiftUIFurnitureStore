//
//  ProductCard.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import Foundation

/// Настройка
struct ProductCard: Hashable {
    /// Имя
    let name: String
    /// Иконка
    let iconName: String
    /// Цена
    let price: String
    /// Новая цена
    var newPrice: Int
    /// идентификатор для продукта
    var id = UUID()
    /// количество данного товара в корзине
    var count = 0
}
