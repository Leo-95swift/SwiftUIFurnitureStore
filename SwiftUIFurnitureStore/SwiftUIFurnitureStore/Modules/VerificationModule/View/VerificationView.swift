//
//  VerificationView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 07.05.24.
//

import SwiftUI

/// Экран для подтверждения кода
struct VerificationView: View {
    
    // MARK: - Constants

    private enum Constants {
        static let navigationTitle = "Verification"
        static let backButtonImageName = "chevron.left"
        static let messageImageName = "messageImage"
        static let verificationCodeText = "Verification code"
        static let checkSMSText = "Check the SMS"
        static let messageToGetVerificationText = "message to get verification code"
        static let continueButtonText = "Continue"
        static let didntReceiveSMSText = "Didn't receive sms"
        static let sendsmsAgainText = "Send sms again"
        static let alertMessage = "Fill in from message"
        static let alertOkText = "Ok"
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            GradientView()
            mainContentView
            .onAppear {
                focused = .firstNumber
            }
            .onTapGesture {
                focused = nil
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationTitle(Constants.navigationTitle)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.backButtonImageName)
                }
                .tint(.white)
            }
        }
    }
    
    // MARK: - Private Properties

    @Environment(\.dismiss) private var dismiss
    @State private var shouldShowProgressView = false
    @State private var shouldShowAlert = false
    @State private var firstNumber = ""
    @State private var secondNumber = ""
    @State private var thirdNumber = ""
    @State private var lastNumber = ""
    @FocusState private var focused: FieldFocusNumber?
    @ObservedObject private var viewModel = SignInViewModel()
    
    
    // MARK: - Visual Elements

    private var mainContentView: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .overlay {
                    VStack {
                        messageImageAndVerificatonCodeView
                        Spacer()
                            .frame(height: 14)
                        messageTextFieldsView
                        Spacer()
                            .frame(height: 20)
                        messageInstructionView
                        Spacer()
                            .frame(height: 20)
                        continueButtonView
                        Spacer()
                            .frame(height: 20)
                        sendSMSagainView
                        Spacer()
                    }
                }
        }
    }
    
    private var messageImageAndVerificatonCodeView: some View {
        VStack {
            Image(Constants.messageImageName)
                .frame(width: 200, height: 200)
            Text(Constants.verificationCodeText)
                .font(.custom(AppConstants.verdanaMediumFontName, size: 20))
                .foregroundStyle(.regularText)
        }
    }
    
    private var messageTextFieldsView: some View {
        HStack {
            TextField("", text: $firstNumber)
                .verificationTextFieldConfiguration()
                .focused($focused, equals: .firstNumber)
                .onChange(of: firstNumber) { _, newValue in
                    if newValue.count >= 1 {
                        firstNumber = String(newValue.prefix(1))
                        focused = .secondNumber
                    }
                }
            TextField("", text: $secondNumber)
                .verificationTextFieldConfiguration()
                .focused($focused, equals: .secondNumber)
                .onChange(of: secondNumber) { _, newValue in
                    if newValue.count >= 1 {
                        secondNumber = String(newValue.prefix(1))
                        focused = .thirdNumber
                    } else if newValue == "" {
                        focused = .firstNumber
                    }
                }
            TextField("", text: $thirdNumber)
                .verificationTextFieldConfiguration()
                .focused($focused, equals: .thirdNumber)
                .onChange(of: thirdNumber) { _, newValue in
                    if newValue.count >= 1 {
                        thirdNumber = String(newValue.prefix(1))
                        focused = .lastNumber
                    } else if newValue == "" {
                        focused = .secondNumber
                    }
                }
            TextField("", text: $lastNumber)
                .verificationTextFieldConfiguration()
                .focused($focused, equals: .lastNumber)
                .onChange(of: lastNumber) { _, newValue in
                    if newValue.count >= 1 {
                        lastNumber = String(newValue.prefix(1))
                        focused = nil
                    } else if newValue == "" {
                        focused = .thirdNumber
                    }
                }
        }
    }
    
    private var messageInstructionView: some View {
        VStack(spacing: 8) {
            Text(Constants.checkSMSText)
                .font(.custom(AppConstants.verdanaBoldFontName, size: 20))
            Text(Constants.messageToGetVerificationText)
                .font(.custom(AppConstants.verdanaMediumFontName, size: 16))
        }
        .foregroundStyle(.regularText)
    }
    
    private var continueButtonView: some View {
        Button {
            shouldShowProgressView.toggle()
        } label: {
            if shouldShowProgressView {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tint(.white)
            } else {
                Text(Constants.continueButtonText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom(AppConstants.verdanaBoldFontName, size: 20))
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 300, height: 55)
        .buttonBackgroundGradient()
        .cornerRadius(25)
        .shadow(color: .gray, radius: 2, y: 4)
    }
    
    private var sendSMSagainView: some View {
        VStack {
            Text(Constants.didntReceiveSMSText)
                .font(.custom(AppConstants.verdanaMediumFontName, size: 20))
            Spacer()
                .frame(height: 7)
            Button {
                shouldShowAlert.toggle()
                viewModel.generateRandomCode()
            } label: {
                Text(Constants.sendsmsAgainText)
                    .font(.custom(AppConstants.verdanaBoldFontName, size: 20))
            }
            .frame(height: 24)
            .alert(isPresented: $shouldShowAlert) {
                Alert(
                    title: Text(Constants.alertMessage),
                    message: Text(viewModel.generatedCode),
                    primaryButton: .default(
                        Text(Constants.alertOkText),
                        action: {
                            viewModel.fillTextField(for: &firstNumber, secondNum: &secondNumber, thirdNum: &thirdNumber, lastNum: &lastNumber)
                        }),
                    secondaryButton: .cancel()
                )
            }
            Divider()
                .frame(width: 160, height: 1.0)
                .background(.signUpBackground)
        }
        .foregroundStyle(.regularText)
    }
    
    // MARK: - Public Methodes

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

#Preview {
    VerificationView()
}
