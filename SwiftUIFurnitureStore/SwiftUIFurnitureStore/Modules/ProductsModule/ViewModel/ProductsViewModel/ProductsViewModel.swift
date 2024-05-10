//
//  ProductsViewModel.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var totalPrice = 0
    
    @Published var allProducts: [ProductCard] = [
        ProductCard(name: "Sofa", iconName: "sofa", price: "2000$", newPrice: 1500),
        ProductCard(name: "Armchair", iconName: "armchair", price: "200$", newPrice: 150),
        ProductCard(name: "Bed", iconName: "bed", price: "1000$", newPrice: 500),
        ProductCard(name: "Table", iconName: "table", price: "260$", newPrice: 130),
        ProductCard(name: "Сhair", iconName: "chair", price: "150$", newPrice: 50),
        ProductCard(name: "Wardrobe", iconName: "wardrobe", price: "1200$", newPrice: 600)
    ]
    
    func updateTotalPrice(id: UUID, change: PriceChange) {
        if let index = allProducts.firstIndex(where: { $0.id == id }) {
            switch change {
            case .plus:
                allProducts[index].count += 1
            case .minus:
                if allProducts[index].count > 0 {
                    allProducts[index].count -= 1
                }
            }
            totalPrice = 0
            
            for product in allProducts {
                totalPrice += product.newPrice * product.count
            }
        }
    }
    
}

enum PriceChange {
    case plus
    case minus
}

