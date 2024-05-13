//
//  PaymentsView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 12.05.24.
//

import SwiftUI

struct PaymentsView: View {
    
    private enum Constants {
        static let cardNumberMask = "XXXX XXXX XXXX XXXX"
        static let eyeSlashImageName = "eye.slash"
        static let eyeImageName = "eye"
  
    }
    @State private var cardHolderDefaultText = "Your name"
    @State private var cardNumberDefaultText = "0000"
    @State private var cardNumberDefaultTextBackSide = "0000 0000 0000 0000"
    @State private var cvcCodeDefaultTextBackSide = "991"
    @State private var cardDay = "01"
    @State private var cardYear = "28"
    
    @Environment(\.dismiss) private var dismiss
    @State private var shouldShowCVCAlert = false
    @State private var cardTapped = false
    @State private var isDateTapped = false
    @State private var isSecureModeOn = false
    @State private var isAlertShown = false
    @State private var cardhHolderNameText = ""
    @State private var cardNumberText = ""
    @State private var cvcCodeText = ""
    @State private var selectedDay = 0
    @State private var selectedYear = 0
    @FocusState private var cardNumberFocused
    @FocusState private var cardholderNameFocused
    @FocusState private var cvcCodeFocused
    

    var body: some View {
        ZStack {
            GradientView()
            VStack {
                Spacer()
                    .frame(height: 30)
                mainContent
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onTapGesture {
            cardNumberFocused = false
            cardholderNameFocused = false
            cvcCodeFocused = false
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Payment")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: AppConstants.backButtonIcon)
                }
                .tint(.white)
            }
        }
    }
    
    private var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    self.cardTapped.toggle()
                }
            }
    }
    
    private var mainContent: some View {
        Rectangle()
            .fill(.white)
            .ignoresSafeArea()
            .overlay {
                VStack {
                    ScrollView {
                        VStack {
                            Spacer()
                                .frame(height: 32)
                            ZStack {
                                greenCardView
                                if isAlertShown {
                                    alertView
                                        .transition(.move(edge: .leading))
//                                        .transition(.opacity)
//                                        .transition(.offset(x: 200, y: -200))
                                        .zIndex(1.0)
                                }
                            }
                            Spacer()
                                .frame(height: 33)
                            cardHolderTextFieldView
                            cardNumberTextFieldView
                            Spacer()
                                .frame(height: 20)
                            pickersView
                            cvcTextFieldView
                        }
                    }
                    addButtonView
                    Spacer()
                        .frame(height: 45)
                }
            }
    }
    
    private var greenCardView: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(LinearGradient(
                colors: [
                    .gradientViewStart,
                    .gradientViewEnd
                ],
                startPoint: .leading,
                endPoint: .trailing)
            )
            .frame(width: 310, height: 180)
            .overlay {
                if cardTapped {
                    greenCardBackSideView
                        .rotation3DEffect(.degrees(cardTapped ? -180 : 0), axis: (x: 1, y: 0, z: 0))
                } else {
                    greenCardFrontSideView
                }
            }
            .rotation3DEffect(.degrees(cardTapped ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .gesture(tap)
    }
    
    private var greenCardFrontSideView: some View {
        VStack {
            HStack {
                Spacer()
                Image("cardLogoImage")
                    .padding()
            }
            HStack {
                Spacer()
                    .frame(width: 30)
                VStack(alignment: .leading) {
                    HStack {
                        Text("**** **** ****")
                        Text(cardNumberDefaultText)
                    }
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    Text("Card number")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.cardDescription)
                }
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                    .frame(width: 30)
                VStack(alignment: .leading) {
                    Text(cardHolderDefaultText)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Text("Cardholder")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.cardDescription)
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    private var greenCardBackSideView: some View {
        VStack {
            Spacer()
                .frame(height: 37)
            HStack {
                Spacer()
                    .frame(width: 30)
                Text(cardNumberDefaultTextBackSide)
                Spacer()
            }
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.white)
            Spacer()
            HStack {
                Spacer()
                    .frame(width: 30)
                Text(cvcCodeDefaultTextBackSide)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Text("CVC/CVV")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.cardDescription)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                    .frame(width: 30)
                Text("\(cardDay)/\(cardYear.suffix(2))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Text("Valid")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.cardDescription)
                Spacer()
            }
            Spacer()
                .frame(height: 42)
        }
    }
    
    private var cardHolderTextFieldView: some View {
        VStack(alignment: .leading) {
            Text("Add new card")
                .font(.custom("Verdana-bold", size: 20))
            TextField("Cardholder name", text: $cardhHolderNameText)
            Divider()
        }
        .focused($cardholderNameFocused)
        .onChange(of: cardhHolderNameText, { _, newValue in
            if newValue != "" {
                cardHolderDefaultText = newValue
            } else {
                cardHolderDefaultText = "Your name"
            }
        })
        .padding(.horizontal)
        .foregroundStyle(.regularText)
    }
    
    private var cardNumberTextFieldView: some View {
        VStack(alignment: .leading) {
            Text("Card number")
                .font(.custom("Verdana-bold", size: 20))
            TextField("0000 0000 0000 0000", text: $cardNumberText)
                .focused($cardNumberFocused)
                .keyboardType(.numberPad)
                .onReceive(cardNumberText.publisher.collect()) {
                    cardNumberText = format(
                        cardNumber: String($0),
                        with: Constants.cardNumberMask
                    )
                    if cardNumberText.count == 22 {
                        cardNumberFocused = false
                    }
                }
                .onChange(of: cardNumberText) { _, newValue in
                    
                    cardNumberDefaultTextBackSide = format(
                        cardNumber: newValue,
                        with: Constants.cardNumberMask
                    )
                    if newValue.count == 22 {
                        let lastNumbers = String(newValue.suffix(4))
                        cardNumberDefaultText = lastNumbers
                    } else if newValue.count == 18 {
                        cardNumberDefaultText = "0000"
                    }
                }
            Divider()
        }
        .padding(.horizontal)
        .foregroundStyle(.regularText)
    }
    
    private var pickersView: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 5) {
                DisclosureGroup("Date") {
                    Picker("", selection: $selectedDay) {
                        ForEach(0..<32) { day in
                                    Text("\(day)")
                                }
                            }
                    .onChange(of: selectedDay) { _, newValue in
                        cardDay = String(newValue)
                    }
                }
                .frame(width: 100)
                Divider()
                    .frame(width: 100)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                DisclosureGroup("Year") {
                    Picker("", selection: $selectedYear) {
                                ForEach(1970..<2010) { year in
                                    Text("\(year)")
                                }
                            }
                    .onChange(of: selectedYear) { _, newValue in
                        cardYear = String(newValue + 1970)
                    }
                }
                .frame(width: 100)
                Divider()
                    .frame(width: 100)
            }
            Spacer()
                .frame(width: 50)

        }
        .tint(.regularText)
    }
    
    private var cvcTextFieldView: some View {
        VStack(alignment: .leading) {
            Text("CVC")
                .font(.custom("Verdana-bold", size: 20))
            HStack {
                if isSecureModeOn {
                    SecureField("***", text: $cvcCodeText)
                        .focused($cvcCodeFocused)
                        .foregroundColor(.backSingupSwitch)
                } else {
                    TextField("000", text: $cvcCodeText)
                        .focused($cvcCodeFocused)
            }
                Button(action: {
                    isSecureModeOn.toggle()
                }) {
                    Image(systemName: isSecureModeOn ? Constants.eyeSlashImageName : Constants.eyeImageName)
                }
            }
            .focused($cvcCodeFocused)
            .onChange(of: cvcCodeText, { oldValue, newValue in
                if newValue.count > 3 {
                    cvcCodeText = oldValue
                    shouldShowCVCAlert = false
                } else if newValue.count < 3{
                    shouldShowCVCAlert = true
                }
                cvcCodeDefaultTextBackSide = cvcCodeText
            })
            .alert(isPresented: $shouldShowCVCAlert) {
                Alert(title: Text("Недостаточно символов"), message: Text("Минимальное количество символов 3"), dismissButton: .default(Text("Oк")))
            }
            .keyboardType(.numberPad)
            Spacer()
            Divider()
                .frame(width: 360)
        }
        .padding()
        .foregroundStyle(.regularText)
    }
    
    private var addButtonView: some View {
        Button {
            withAnimation {
                isAlertShown.toggle()
            }
            print("tapped")
        } label: {
                Text("Add now")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom(AppConstants.verdanaBoldFontName, size: 20))
                    .foregroundStyle(.white)
        }
        .frame(width: 300, height: 55)
        .buttonBackgroundGradient()
        .cornerRadius(25)
        .shadow(color: .gray, radius: 2, y: 4)
    }
    
    private var alertView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
            .fill(.textGrey)
            .frame(width: 310, height: 180)
            VStack(spacing: 20) {
                Text("Карта добавлена")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                HStack(spacing: 40) {
                    Image("done")
                        .resizable()
                        .cornerRadius(40)
                        .frame(width: 80, height: 80)
                    Button("Ok") {
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    }
                    .font(.system(size: 18))
                    .bold()
                    .foregroundColor(.white)
                }
            }
            .shadow(radius: 15)
        }
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    public func format(cardNumber: String, with mask: String) -> String {
        let numbers = cardNumber.replacingOccurrences(
            of: "[^0-9]",
            with: "",
            options: .regularExpression
        )
        var result = ""
        var count = 0

        for char in mask {
            if count < numbers.count {
                if char == "X" {
                    result.append(numbers[numbers.index(
                        numbers.startIndex,
                        offsetBy: count)]
                    )
                    count += 1
                    if count % 4 == 0 && count < numbers.count {
                        result.append(" ")
                    }
                } else {
                    result.append(char)
                }
            }
        }
        return result
    }
}

#Preview {
    PaymentsView()
}

