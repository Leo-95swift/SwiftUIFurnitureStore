//
//  FiltersViewModel.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 10.05.24.
//

import Foundation

/// для бизнес логики экрана фильтеров
final class FiltersViewModel: ObservableObject {
    
    enum Constants {
        static let armchair = "armchairScroll"
        static let bed = "bedScroll"
        static let sofa = "sofaScroll"
    }
    
    @Published var categories: [Category] =  [
        .init(image: Constants.bed),
        .init(image: Constants.sofa),
        .init(image: Constants.armchair)
    ]
    
    @Published var colorCircles: [ColorCircle] =  [
        .init(colorName: "white", color: .white),
        .init(colorName: "black", color: .black),
        .init(colorName: "textGrey", color: .textGrey),
        .init(colorName: "pink", color: .pink),
        .init(colorName: "yellow", color: .yellow),
        .init(colorName: "red", color: .red),
        .init(colorName: "blue", color: .blue),
        .init(colorName: "green", color: .green),
        .init(colorName: "purple", color: .purple),
        .init(colorName: "orange", color: .orange),
        .init(colorName: "priceCol", color: .priceCol),
        .init(colorName: "backCell", color: .backCell),
        .init(colorName: "cyan", color: .cyan),
        .init(colorName: "backSingupSwitch", color: .backSingupSwitch),
        .init(colorName: "priceColGreen", color: .priceColGreen),
        .init(colorName: "sliderCircle", color: .sliderCircle),
        .init(colorName: "sliderNotSelected", color: .sliderNotSelected),
        .init(colorName: "stepperBackground", color: .stepperBackground),
        .init(colorName: "topGragient", color: .topGragient),
        .init(colorName: "indigo", color: .indigo)
    ]
    
    @Published public var sliderValue: Double = 5000
    @Published public var positionValue: CGFloat = 150
    @Published public var selectedColor = ""
    
    func updateSelectedColor(_ colorCircleId: UUID) {
        if let index = colorCircles
            .firstIndex(where: { $0.id == colorCircleId }) {
            selectedColor = colorCircles[index].colorName
        }
    }
    
    func getPosition(for sliderValue: Double) {
        switch sliderValue {
        case 500:
            positionValue = -160
        case 1000:
            positionValue = -140
        case (1500...4500):
            positionValue = (sliderValue - 1000) / 500 * 40 - 140
        case 5000:
            positionValue = 160
        default:
            positionValue = 180
        }
    }
    
}
