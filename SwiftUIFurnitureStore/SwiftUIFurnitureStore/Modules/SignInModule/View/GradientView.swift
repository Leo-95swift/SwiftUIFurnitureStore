//
//  GradientView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 08.05.24.
//

import SwiftUI

/// Вью градиента
struct GradientView: View {
    var body: some View {
        LinearGradient(
            colors: [
                .gradientViewStart,
                .gradientViewEnd
            ],
            startPoint: .leading,
            endPoint: .trailing
        ).ignoresSafeArea()
    }
}
