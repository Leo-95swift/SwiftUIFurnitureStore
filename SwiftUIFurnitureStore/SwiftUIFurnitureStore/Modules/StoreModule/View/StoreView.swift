//
//  StoreView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 06.05.24.
//

import SwiftUI

struct StoreView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let title = "Sofa Elda 900"
        static let isFavoriteButton = "isFavorite"
        static let sofaImage = "sofa"
        static let buyNowButton = "Buy now"
        static let articleLabel = "Article: 283564"
        static let priceButtonText = "Price: 999$"
        static let articleDescription = """
                    Description: A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design.
                """
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                furnitoreInfoView
                reviewView
            }
        }
    }
    
    // MARK: - Visual Elements
    
    var reviewView: some View {
        ZStack {
            GradientView(
                startColor: .gradientViewStart,
                endColor: .gradientViewEnd
            )
            .cornerRadius(14)
            .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading) {
                    VStack {
                        otherInfoView
                        Text("Review")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .bold()
                    }
                    Text("Nothing yet")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                }.padding()
                
                buyNowButtonView
            }
        }
    }
    
    var otherInfoView: some View {
        VStack(alignment: .leading) {
            Text(Constants.articleLabel)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .bold()
            
            Text(Constants.articleDescription).foregroundColor(.white)
                .font(.system(size: 16))
                .bold()
            
        }.padding()
    }
    
    var buyNowButtonView: some View {
        Button {
            
        } label: {
            ZStack {
                Color(.white)
                GradientText(
                    text: Constants.buyNowButton,
                    startColor: .gradientTextStart,
                    endColor: .gradientTextEnd
                )
            }
        }
        .frame(width: 300, height: 55)
        .cornerRadius(27)
    }
    
    var furnitoreInfoView: some View {
        VStack {
            titleView
            Image(Constants.sofaImage)
            HStack() {
                Spacer()
                Text(Constants.priceButtonText)
                    .frame(width: 190, height: 44)
                    .background(Color.priceColorBackground)
                    .cornerRadius(10)
            }.padding()
        }
    }
    
    var titleView: some View {
        HStack {
            Text(Constants.title)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.storeTitle)
            Spacer()
            Button {
                print("didTapIsFavoriteButton")
            } label: {
                Image(Constants.isFavoriteButton)
            }
        }.padding()
    }
    
}

#Preview {
    StoreView()
}
