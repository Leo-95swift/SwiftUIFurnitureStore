//
//  GradientView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 06.05.24.
//

import SwiftUI

struct GradientView: View {
    
    // MARK: - Private Properties

    var startColor: Color
    var endColor: Color
    
    // MARK: - Body

    var body: some View {
        
        let gradient = LinearGradient(
            gradient: Gradient(colors: [
                startColor,
                endColor
            ]),
            startPoint: .top,
            endPoint: .bottom
        )

        return Rectangle()
            .fill(gradient)
            .edgesIgnoringSafeArea(.all)
    }
}
