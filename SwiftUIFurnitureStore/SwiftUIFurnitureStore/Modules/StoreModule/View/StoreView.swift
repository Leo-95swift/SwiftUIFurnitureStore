//
//  StoreView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 06.05.24.
//

import SwiftUI

/// Вью для экрана магазина
struct StoreView: View {
    
    // MARK: - Constants
    private enum Constants {
        static let heartImageName = "heart"
        static let priceText = "Price:"
        static let articleText = "Article: "
        static let descriptionText = "Description: "
        static let reviewText = "Review"
        static let maximumValue = "/300"
        static let buyNowText = "Buy now"
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack() {
                Spacer()
                    .frame(height: (39))
                furnitureNameView
                Image(productCard.iconName)
                    .resizable()
                    .frame(width: 300, height: 177)
                furniturePriceView
                furnitureDescriptionView
            }
        }
        .onAppear() {
            viewModel.inputText = productCard.review
        }
        .onTapGesture {
            focused = false
        }
        .offset(y: CGFloat(offset))
        .ignoresSafeArea(.keyboard)
        .animation(.default)
    }
    
    var productCard: ProductCard
    
    @ObservedObject private var viewModel = StoreViewModel()
    @State private var offset = 0
    @FocusState private var focused
    @EnvironmentObject private var productViewModel: ProductsViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var furnitureNameView: some View {
        HStack {
            Text(productCard.name)
                .boldTextConfiguration()
            Spacer()
            Button {
            } label: {
                Image(systemName: Constants.heartImageName)
            }
            .tint(.black)
        }
        .padding(.horizontal)
    }
    
    private var furniturePriceView: some View {
        HStack {
            Spacer()
            Text("\(Constants.priceText) \(productCard.newPrice)$")
                .frame(width: 191, height: 54)
                .boldTextConfiguration()
                .background(Color.priceColorBackground)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15))
        }
    }
    
    private var furnitureDescriptionView: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(LinearGradient(
                colors: [
                    .gradientViewStart,
                    .gradientViewEnd
                ],
                startPoint: .top,
                endPoint: .bottom)
            )
            .ignoresSafeArea()
            .overlay {
                VStack {
                    Spacer()
                        .frame(height: 24)
                    descriptionView
                    Spacer()
                    textEditorView
                    Spacer()
                        .frame(height: 32)
                    buyButtonView
                    Spacer()
                }
            }
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.articleText)
                    .font(.custom(AppConstants.verdanaBoldFontName, size: 16))
                +
                Text(String(productCard.articule))
                    .font(.custom(AppConstants.verdanaFontName, size: 16))
            }
            Spacer()
                .frame(height: 6)
            HStack {
                Text(Constants.descriptionText)
                    .font(.custom(AppConstants.verdanaBoldFontName, size: 16))
                +
                Text("\(productCard.description)")
                    .font(.custom(AppConstants.verdanaFontName, size: 16))
            }
        }
        .foregroundStyle(.white)
    }
    
    private var textEditorView: some View {
        VStack {
            Text(Constants.reviewText)
                .font(.custom(AppConstants.verdanaBoldFontName, size: 16))
            HStack(alignment: .top) {
                TextEditor(text: $viewModel.inputText)
                    .frame(width: 300, height: 177)
                    .scrollContentBackground(.hidden)
                    .multilineTextAlignment(.leading)
                    .focused($focused)
                    .onChange(of: focused) { _, newValue in
                        if newValue {
                            offset = -300
                        } else {
                            offset = 0
                        }
                    }
                VStack {
                    Spacer()
                        .frame(height: 10)
                    Text("\(viewModel.totalCharNumber)\(Constants.maximumValue)")
                        .font(.custom(AppConstants.verdanaMediumFontName, size: 14))
                    Spacer()
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    private var buyButtonView: some View {
        Button {
            dismiss()
        } label: {
            Text(Constants.buyNowText)
                .buttonTextGradient()
        }
        .frame(width: 300, height: 55)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

