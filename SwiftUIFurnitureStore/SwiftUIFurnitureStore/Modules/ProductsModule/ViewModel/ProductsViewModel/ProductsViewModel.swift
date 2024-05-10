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
        ProductCard(
            name: ProductsConstants.name1,
            iconName: ProductsConstants.iconName1,
            price: ProductsConstants.price1,
            newPrice: 1500,
            articule: ProductsConstants.articule1,
            description: ProductsConstants.description1,
            review: ProductsConstants.review1
        ),
        
        ProductCard(
            name: ProductsConstants.name2,
            iconName: ProductsConstants.iconName2,
            price: ProductsConstants.price2,
            newPrice: 150,
            articule: ProductsConstants.articule2,
            description: ProductsConstants.description2,
            review: ProductsConstants.review2
        ),
        
        ProductCard(
            name: ProductsConstants.name3,
            iconName: ProductsConstants.iconName3,
            price: ProductsConstants.price3,
            newPrice: 500,
            articule: ProductsConstants.articule3,
            description: ProductsConstants.description3,
            review: ProductsConstants.review3
        ),
        
        ProductCard(
            name: ProductsConstants.name4,
            iconName: ProductsConstants.iconName4,
            price: ProductsConstants.price4,
            newPrice: 130,
            articule: ProductsConstants.articule4,
            description: ProductsConstants.description4,
            review: ProductsConstants.review4
        ),
        
        ProductCard(
            name: ProductsConstants.name5,
            iconName: ProductsConstants.iconName5,
            price: ProductsConstants.price5,
            newPrice: 50,
            articule: ProductsConstants.articule5,
            description: ProductsConstants.description5,
            review: ProductsConstants.review5
        ),
        
        ProductCard(
            name: ProductsConstants.name6,
            iconName: ProductsConstants.iconName6,
            price: ProductsConstants.price6,
            newPrice: 600,
            articule: ProductsConstants.articule6,
            description: ProductsConstants.description6,
            review: ProductsConstants.review6
        )
    ]
    
    func getProduct(with id: UUID) -> ProductCard? {
        if let index = allProducts.firstIndex(where: { $0.id == id }) {
            return allProducts[index]
        } else {
            return nil
        }
    }

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

