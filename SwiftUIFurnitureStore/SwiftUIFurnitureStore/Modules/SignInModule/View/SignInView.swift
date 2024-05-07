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
        static let logIn = "Log in"
        static let signUpLabel = "Sign up"
        static let signUpButton = "Sign up"
    }
    
    // MARK: - @State Properties
    
    @State var numberTextFIeldText = ""
    @State var passwordTextFIeldText = ""

    // MARK: - Body

    var body: some View {
        VStack {
            gradientView
                .frame(height: 30)
            ZStack {
                Color(.white)
                VStack(spacing: 40) {
                    VStack {
                        HStack(spacing: -20) {
                            loginView
                            signUpView
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            numberTextFieldView
                            Text("Password")
                            
                            passwordTextFieldView
                        }.padding()
                    }
                    VStack(spacing: 24) {
                        signUpButtonView
                        VStack(spacing: 18) {
                            Text("Forgot your password?")
                                .font(.system(size: 20))
                                .bold()
                            Text("Check Verification")
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Visual Elements
    
    private var signUpButtonView: some View {
        Button {
            
        } label: {
            ZStack {
                LinearGradient(
                    colors: [
                        .gradientViewStart,
                        .gradientViewEnd
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: 300, height: 55)
                .cornerRadius(27)
                Text(Constants.signUpButton)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .bold()
            }
        }.shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
    
    private var numberTextFieldView: some View {
        TextField("Введите номер", text: $numberTextFIeldText)
            .textFieldStyle(.automatic)
            .foregroundColor(.accentColor)
            .font(.system(size: 20))
            .keyboardType(.numberPad)
            .padding(.horizontal)
    }
    
    private var passwordTextFieldView: some View {
        TextField("Введите пароль", text: $passwordTextFIeldText)
            .textFieldStyle(.automatic)
            .foregroundColor(.accentColor)
            .font(.system(size: 20))
            .keyboardType(.numberPad)
            .padding(.horizontal)
    }
    
    private var loginView: some View {
        Text(Constants.logIn)
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
            .frame(width: 150, height: 50)
            .background(Color.white)
            .border(.signUpBackground, width: 2)
            .cornerRadius(27)
    }
    
    
    private var signUpView: some View {
        Text(Constants.signUpLabel)
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
            .frame(width: 150, height: 50)
            .background(Color.signUpBackground)
            .border(.signUpBackground, width: 2)
            .cornerRadius(27)
    }
    
    private var gradientView: some View {
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

#Preview {
    SignInView()
}
