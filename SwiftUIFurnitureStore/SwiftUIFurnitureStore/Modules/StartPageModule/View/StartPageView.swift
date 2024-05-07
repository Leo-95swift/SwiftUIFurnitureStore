//
//  StartPageView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 06.05.24.
//

import SwiftUI

/// Стартовый экран приложения
struct StartPageView: View {
        
    // MARK: - Constants

    enum Constants {
        static let title = "169.ru"
        static let logo = "logo"
        static let getStartedButton = "Get Started"
        static let hasAccountLabel = "Don't have an account?"
        static let signInButton = "Sign in here"
    }
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        .gradientViewStart,
                        .gradientViewEnd
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                VStack(spacing: 100) {
                    siteInfoView
                    getStartedButtonView
                    signInView
                }
            }
        }
    }
    
    // MARK: - Visual Elements
    
    var signInView: some View {
        VStack(spacing: 12) {
            Text(Constants.hasAccountLabel)
                .font(.system(size: 16))
                .bold()
                .foregroundColor(.white)
            
            NavigationLink {
                SignInView()
            } label: {
                Text(Constants.signInButton)
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(.white)
            }
            
        }
    }
    
    var getStartedButtonView: some View {
        NavigationLink {
            StoreView()
        } label: {
            ZStack {
                Color(.white)
                Text(Constants.getStartedButton)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [
                                .gradientTextStart,
                                .gradientTextEnd
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                    .font(.system(size: 24))
                    .bold()
            }
        }
        .frame(width: 300, height: 55)
        .cornerRadius(27)
    }

    var siteInfoView: some View {
        VStack {
            Text(Constants.title)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(.white)
            
            Image(Constants.logo)
        }
        .padding()
    }
    
}

#Preview {
    StartPageView()
}
