//
//  TabView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 10.05.24.
//

import SwiftUI

/// Главный таб бар приложения
struct TabBarView: View {
    
    // MARK: - Constants

    enum Constants {
        static let profileTabIcon = "profileTabbar"
        static let basketTabIcon = "basketTabbar"
        static let productsTabIcon = "productsTabbar"
    }
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TabView {
                
                ProductsView()
                    .tabItem {
                        Image(Constants.productsTabIcon)
                            .renderingMode(.template)
                    }
                BasketView()
                    .tabItem {
                        Image(Constants.basketTabIcon)
                            .renderingMode(.template)
                    }
                ProfileView()
                    .tabItem {
                        Image(Constants.profileTabIcon)
                            .renderingMode(.template)
                    }
            }
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
                UITabBar.appearance().barTintColor = .white
            }
            .tint(.priceColGreen)
        }
        
    }
}

#Preview {
    TabBarView()
}
