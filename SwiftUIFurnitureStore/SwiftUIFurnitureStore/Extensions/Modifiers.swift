//
//  Modifiers.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 07.05.24.
//

import SwiftUI

struct ButtonTextGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.custom("Verdana-bold", size: 20))
            .foregroundStyle(LinearGradient(
                colors: [
                    .gradientTextStart,
                    .gradientViewEnd
                ],
                startPoint: .top,
                endPoint: .bottom)
            )
    }
}

struct ButtonBackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(colors: [
                .gradientTextStart,
                .gradientViewEnd
            ],
            startPoint: .leading,
            endPoint: .trailing
            )
        )
    }
}

struct BoldTextConfiguration: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Verdana-bold", size: 20))
            .foregroundStyle(.regularText)
    }
}

struct VerificationTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 60, height: 60)
            .multilineTextAlignment(.center)
            .font(.custom("Verdana-medium", size: 40))
            .keyboardType(.numberPad)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.signUpBackground, lineWidth: 2)
            }
    }
}

