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
        static let imageURL = "https://png.pngtree.com/png-vector/20240125/ourmid/pngtree-yellow-sofa-furniture-png-image_11548333.png"
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
                    VStack(spacing: 0) {
                        VStack(spacing: 10) {
                            getStartedButtonView
                                .opacity(buttonOpacity)
                            loadingIndicatorView
                                .opacity(loadingIndicatorOpacity)
                        }
                        VStack {
                            signInView
                            NavigationLink(destination: SignInView(), isActive: $shouldNavigate) {
                                EmptyView()
                            }
                        }
                    }
                }
            }.onAppear {
                animateInSequence()
            }
        }
    }
    
    // MARK: - State for animation
    
    @State private var titleTextOpacity = 0.0
    @State private var imageOpacity = 0.0
    @State private var buttonOpacity = 0.0
    @State private var loadingIndicatorOpacity = 0.0
    @State private var accountTextOpacity = 0.0
    @State private var signInTextOpacity = 0.0
    @State private var rotationDegrees = 0.0
    @State private var getStartedButtonLongPressed = false
    @State private var signInButtonTapped = false
    @State private var shouldNavigate = false

    private var titleTextDelay = 0.5
    private var imageDelay = 1.0
    private var buttonDelay = 1.5
    private var accountTextDelay = 2.0
    private var SignInTextDelay = 2.5

    // MARK: - Visual Elements
    
    private var signInView: some View {
        VStack(spacing: 12) {
            Text(Constants.hasAccountLabel)
                .font(.system(size: 16))
                .bold()
                .foregroundColor(.white)
                .opacity(accountTextOpacity)
            
            Button(action: {
                loadingForSignIn()
            }) {
                Text(Constants.signInButton)
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(.white)
                    .opacity(signInTextOpacity)
            }
            
        }
    }
    
    private var getStartedButtonView: some View {
        NavigationLink {
           TabBarView()
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
            }.gesture(long)
        }
        .frame(width: 300, height: 55)
        .cornerRadius(27)
    }
    
    private var loadingIndicatorView: some View {
         Image(systemName: "circle.hexagonpath")
             .rotationEffect(.degrees(rotationDegrees))
             .frame(width: 100, height: 100)
             .scaleEffect(2)
             .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false), value: rotationDegrees)
             .onAppear {
                 rotationDegrees = 360
             }
     }

    private var siteInfoView: some View {
        ZStack {
            VStack {
                Text(Constants.title)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .opacity(titleTextOpacity)
                
                asyncImageView
                    .opacity(imageOpacity)
                    .opacity(
                        getStartedButtonLongPressed ? 0.0 : 1.0
                    )
            }
            .padding()
            Text("Всем на пол !!! \n Над проектом\nработает Лёва")
                .font(.system(size: 40))
                .bold()
                .foregroundColor(.white)
                .opacity(
                    getStartedButtonLongPressed ? 1.0 : 0.0
                )
                
        }
    }
    
    private var asyncImageView: some View {
        AsyncImage(url: URL(string: Constants.imageURL)) { image in
            image
                .resizable()
                .renderingMode(.original)
                .frame(width: 300, height: 300)
        } placeholder: {
            ProgressView()
                .tint(.white)
        }
    }
    
    var long: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .onEnded { _ in
                withAnimation() {
                    getStartedButtonLongPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                     withAnimation() {
                         getStartedButtonLongPressed = false
                         animateInSequence()
                     }
                 }
            }
    }
    
    // MARK: - Private Methods
    
    private func animateInSequence() {
        withAnimation(.easeIn(duration: 0.5)) {
            titleTextOpacity = 1.0
        }
        withAnimation(.easeIn(duration: 0.5).delay(1.0)) {
            imageOpacity = 1.0
        }
        withAnimation(.easeIn(duration: 0.5).delay(1.5)) {
            buttonOpacity = 1.0
        }
        withAnimation(.easeIn(duration: 0.5).delay(2.0)) {
            accountTextOpacity = 1.0
        }
        withAnimation(.easeIn(duration: 0.5).delay(2.5)) {
            signInTextOpacity = 1.0
        }
    }
    
    private func loadingForSignIn() {
        loadingIndicatorOpacity = 1.0
        withAnimation(.easeIn(duration: 3.0)) {
            rotationDegrees = 360
        }

            // Delay the navigation
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                rotationDegrees = 0
                shouldNavigate = true
            }
    }
}

#Preview {
    StartPageView()
}
