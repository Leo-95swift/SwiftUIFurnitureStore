//
//  StoreViewModel.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 07.05.24.
//

import Foundation

/// класс для бизнес логики экрана магазина
final class StoreViewModel: ObservableObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let name = "Sofa Elda 900"
        static let imageName = "sofa"
        static let price = 999
        static let article = 283564
        static let description = "A sofa in a modern style is furniture without lush ornate decor. It has\na simple or even futuristic appearance and sleek design."
        static let review = "This sofa looks great"
    }
    
    // MARK: - Public Properties
    
    @Published public var totalCharNumber = 0
    @Published public var inputText = "" {
        didSet {
            updateText()
        }
    }
    public var lastText = ""
    public var furniture: [Furniture] = [
        Furniture(
            name: Constants.name,
            imageName: Constants.imageName,
            price: Constants.price,
            article: Constants.article,
            description: Constants.description
        )]

    // MARK: - Private Methods
    
    private func updateText() {
        totalCharNumber = inputText.count
        if totalCharNumber <= 300 {
            lastText = inputText
        } else {
            inputText = lastText
        }
    }
    
}
