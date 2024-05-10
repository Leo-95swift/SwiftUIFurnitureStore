//
//  ProductCard.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import Foundation

/// Описание мебельи
struct ProductCard: Hashable, Identifiable {
    /// Имя
    let name: String
    /// Иконка
    let iconName: String
    /// Цена
    let price: String
    /// Новая цена
    var newPrice: Int
    /// Артикуль товара
    var articule: String
    /// Описание товара
    var description: String
    /// Отзыви о товаре
    var review: String
    /// Идентификатор для продукта
    var id = UUID()
    /// Количество данного товара в корзине
    var count = 0
}
