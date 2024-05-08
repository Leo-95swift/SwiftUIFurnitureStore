//
//  SignInViewModel.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 08.05.24.
//

import SwiftUI

/// Вью модель экрана авторизации
class SignInViewModel: ObservableObject {

    // MARK: - Public Properties
    
    @Published public var generatedCode = ""
    
    // MARK: - Public Methods
    
    public func format(phoneNumber: String, with mask: String) -> String {
        let numbers = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    public func generateRandomCode() {
        var randomCode = ""
        for _ in 0...3 {
            randomCode += "\(Int.random(in: 0...9))"
        }
        DispatchQueue.main.async {
            self.generatedCode = randomCode
        }
    }
    
    public func fillTextField(for
                              firstNum: inout String,
                              secondNum: inout String,
                              thirdNum: inout String,
                              lastNum: inout String) {
            let characters = Array(self.generatedCode)
            firstNum = String(characters[0])
            secondNum = String(characters[1])
            thirdNum = String(characters[2])
            lastNum = String(characters[3])
    }
}
