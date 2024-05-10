//
//  View+Extension.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 07.05.24.
//

import SwiftUI

/// Расширение для добавления финкциональности для вью
extension View {
    func buttonTextGradient() -> some View {
        modifier(ButtonTextGradientModifier())
    }
    
    func buttonBackgroundGradient() -> some View {
        modifier(ButtonBackgroundGradientModifier())
    }

    func boldTextConfiguration() -> some View {
        modifier(BoldTextConfiguration())
    }
    
    func verificationTextFieldConfiguration() -> some View {
        modifier(VerificationTextFieldModifier())
    }

}
