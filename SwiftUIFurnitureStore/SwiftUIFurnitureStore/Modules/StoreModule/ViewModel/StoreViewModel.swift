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
        static let review = ""
    }
    
    // MARK: - Public Properties
    
    @Published public var totalCharNumber = 0
    @Published public var inputText = "" {
        didSet {
            updateText()
        }
    }
    public var lastText = ""

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
