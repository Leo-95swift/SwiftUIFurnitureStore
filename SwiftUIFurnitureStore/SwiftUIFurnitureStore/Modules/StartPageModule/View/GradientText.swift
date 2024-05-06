//
//  GradientText.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 06.05.24.
//

import SwiftUI

struct GradientText: View {
    var text: String
    var startColor: Color
    var endColor: Color

    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [
                startColor,
                endColor
            ]),
            startPoint: .top,
            endPoint: .bottom
        )

        return Text(text)
            .font(.title)
            .fontWeight(.bold)
            .overlay(
                gradient
                    .mask(
                        Text(text)
                            .font(.title)
                            .fontWeight(.bold)
                    )
            )
    }
}
