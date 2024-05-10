//
//  ProductsView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 09.05.24.
//

import SwiftUI

struct ProductsView: View {
    
    private enum Constants {
        static let priceLabel = "Your total price "
    }
    
    @ObservedObject private var productsViewModel = ProductsViewModel()
    @State private var search = ""
    @State private var isShowStoreView = false
    
    @State private var selectedProduct: ProductCard?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Spacer()
                    searchField
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                Spacer()
                                    .frame(height: 20)
                                productTotalPrice
                                scrollView
                            }
                            
                        }
                }
            }
            .environmentObject(productsViewModel)
        }
    }
    
    private var searchField: some View {
        HStack() {
            HStack() {
                Group() {
                    Image(.glass)
                    TextField("Search...", text: $search)
                        .padding(.leading, -20)
                }
                .padding( 10)
            }
            .background()
            .clipShape(.rect(cornerRadius: 24))
            .frame(width: 312, height: 48)
            .padding(.leading, 20)
            Spacer().frame(width: 10)
            NavigationLink {
                FiltersView()
            } label: {
                Image(.filter)
            }
        }
    }
    
    private var productTotalPrice: some View {
        HStack {
            Text("\(Constants.priceLabel) \(productsViewModel.totalPrice)$ ")
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(.textGrey)
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(.priceColGreen)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
    }
    
    private var scrollView: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(productsViewModel.allProducts, id: \.id) { product in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.backCell)
                            .frame(height: 150)
                            .shadow(radius: 2, x: 0.0, y: 4.0)
                            .padding(.horizontal, 15)
                        makeProductCellView(product: product)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        
    }
    
    private func makeProductCellView(product: ProductCard) -> some View {
        
        HStack() {
            Button(action: {
                selectedProduct = product
            }, label: {
                Image(product.iconName)
                    .resizable()
                    .frame(width: 140, height: 140)
                Spacer().frame(width: 50)
            })
            .fullScreenCover(item: $selectedProduct) { product in
                StoreView(productCard: product)
            }
            VStack {
                Text(product.name)
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundStyle(.textGrey)
                HStack() {
                    Text("\(product.newPrice)$")
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundStyle(.priceColGreen)
                    Text("\(product.price)$")
                        .font(.system(size: 20))
                        .strikethrough(true, color: .textGrey)
                }
                stepperView(for: product)
            }
        }
        .foregroundStyle(.textGrey)
        
    }
    
    private func stepperView(for product: ProductCard) -> some View {
        ZStack {
            Color.stepperBackground
                .frame(width: 115, height: 40)
                .cornerRadius(24)
            HStack(spacing: 12) {
                Button {
                    if product.count > 0 {
                        productsViewModel.updateTotalPrice(id: product.id, change: .minus)
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 18))
                        .bold()
                }
                
                Text("\(product.count)")
                    .font(.system(size: 18))
                    .bold()
                    .frame(width: 40)
                
                Button {
                    productsViewModel.updateTotalPrice(id: product.id, change: .plus)
                } label: {
                    Text("+")
                        .font(.system(size: 18))
                        .bold()
                }
            }
        }
    }
}

#Preview {
    ProductsView()
}
