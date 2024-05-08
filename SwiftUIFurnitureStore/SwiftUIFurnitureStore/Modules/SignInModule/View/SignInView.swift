//
//  SignInView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 07.05.24.
//

import SwiftUI

/// Стартовый экран приложения
struct SignInView: View {
    
    // MARK: - Constants

    enum Constants {
        static let logInText = "Log in"
        static let signUpText = "Sign up"
        static let logintPlaceholder = "Phone number"
        static let passwordPlaceholder = "Password"
        static let phoneNumberMask = "+X (XXX) XXX-XX-XX"
        static let eyeSlashImageName = "eye.slash"
        static let eyeImageName = "eye"
        static let forgotPasswordText = "Forgot your password?"
        static let alertTitleText = "Забыли пароль?"
        static let alertMessage = "Обратитесь в тех.поддержку по номеру\n8-800-555-35-35"
        static let alertOk = "Ок"
        static let checkVerificationText = "Check Verification"
    }
    
    // MARK: - @State Properties
    
    @State private var loginText = ""
    @State private var passwordText = ""
    @State private var isSecureModeOn = false
    @State private var shouldShowAlert = false
    @State private var shouldShowDetailView = false
    @FocusState private var loginFocused
    @FocusState private var passwordFocused
    @ObservedObject private var viewModel = SignInViewModel()

    // MARK: - Body
    
    var body: some View {
        ZStack {
            GradientView()
            VStack {
                Spacer()
                    .frame(height: 30)
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
                    .overlay {
                        mainContentView
                    }
            }
            .onTapGesture {
                loginFocused = false
                passwordFocused = false
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Visual Elements
    
    private var mainContentView: some View {
        VStack {
            Spacer()
                .frame(height: 39)
            twoAuthSegmentsView
            Spacer()
                .frame(height: 76)
            textFieldsView
            Spacer()
                .frame(height: 95)
            signUpButtonView
            Spacer()
                .frame(height: 24)
            forgotPasswordView
            Spacer()
                .frame(height: 18)
            verificationView
            Divider()
                .frame(width: 160, height: 1.0)
                .background(.signUpBackground)
            Spacer()
        }
    }
    
    private var twoAuthSegmentsView: some View {
        VStack {
            HStack(spacing: 0) {
                Text(Constants.logInText)
                    .buttonTextGradient()
                    .frame(width: 148, height: 55)
                    
                Text(Constants.signUpText)
                    .buttonTextGradient()
                    .frame(width: 148, height: 55)
                    .background(.signUpBackground)
            }
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color.signUpBackground, lineWidth: 3)
            }
        }
    }
    
    private var loginTextFieldView: some View {
        VStack {
            TextField(Constants.logintPlaceholder, text: $loginText)
                .focused($loginFocused)
                .keyboardType(.numberPad)
                .onReceive(loginText.publisher.collect()) {
                    loginText = viewModel.format(
                        phoneNumber: String($0.prefix(18)),
                        with: Constants.phoneNumberMask
                    )
                    if loginText.count == 18 {
                        passwordFocused = true
                    }
                }
                .padding(.horizontal)
            Spacer()
                .frame(height: 12)
            Divider()
                .frame(width: 360, height: 1)
                .background(.signUpBackground)
        }
    }
    
    private var passwordTitleView: some View {
        Text(Constants.passwordPlaceholder)
            .font(.custom(AppConstants.verdanaBoldFontName, size: 16))
            .padding(.horizontal)
    }
    
    private var passwordTextFieldView: some View {
        VStack {
            HStack {
                if isSecureModeOn {
                    SecureField(Constants.passwordPlaceholder, text: $passwordText)
                        .focused($passwordFocused)
                        .padding(.horizontal)
                        .foregroundColor(.signUpBackground)
                } else {
                    TextField(Constants.passwordPlaceholder, text: $passwordText)
                        .padding(.horizontal)
                        .focused($passwordFocused)
                }
                Button(action: {
                    isSecureModeOn.toggle()
                }) {
                    Image(systemName: isSecureModeOn ? Constants.eyeSlashImageName : Constants.eyeImageName)
                }
                .padding(.horizontal)
            }
            .frame(height: 22)
            Spacer()
                .frame(height: 12)
            Divider()
                .frame(width: 360, height: 1)
                .background(.signUpBackground)
        }
    }
    
    private var textFieldsView: some View {
        VStack(alignment: .leading) {
            loginTextFieldView
            Spacer()
                .frame(height: 24)
            passwordTitleView
            Spacer()
                .frame(height: 8)
            passwordTextFieldView
        }
        .foregroundStyle(.regularText)
    }
    
    private var signUpButtonView: some View {
        Button {
            shouldShowDetailView.toggle()
        } label: {
            Text(Constants.signUpText)
                .font(.custom(AppConstants.verdanaBoldFontName, size: 20))
                .foregroundStyle(.white)
        }
        .frame(width: 300, height: 55)
        .buttonBackgroundGradient()
        .cornerRadius(25)
        .shadow(color: .gray, radius: 3, y: 4)
        .fullScreenCover(isPresented: $shouldShowDetailView, content: {
            StoreView()
        })
    }
    
    private var forgotPasswordView: some View {
        Button {
            shouldShowAlert.toggle()
        } label: {
            Text(Constants.forgotPasswordText)
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(Constants.alertTitleText), message: Text(Constants.alertMessage), dismissButton: .default(Text(Constants.alertOk)))
        }
        .boldTextConfiguration()
    }
    
    private var verificationView: some View {
        NavigationLink(destination: VerificationView()) {
            Text(Constants.checkVerificationText)
        }
        .frame(height: 24)
        .boldTextConfiguration()
    }
}

#Preview {
    SignInView()
}
