//
//  FiltersView.swift
//  SwiftUIFurnitureStore
//
//  Created by Levon Shaxbazyan on 10.05.24.
//

import SwiftUI

struct FiltersView: View {
    
    enum Constants {
        static let category = "Category"
        static let navigationTitle = "Filters"
        static let color = "Color"
        static let prices = "Prices"
        static let minPrice = "$500"
        static let more = "More"
        static let backButtonIcon = "chevron.left"
        static let detailButtonIcon = "chevron.right"
        
    }
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var filtersViewModel = FiltersViewModel()
    
    let rows: [GridItem] = [
        .init(.fixed(50))
    ]
    
    let columns: [GridItem] = [
        .init(.fixed(50)),
        .init(.fixed(50)),
        .init(.fixed(50)),
        .init(.fixed(50)),
        .init(.fixed(50))
    ]
    
    @State private var maxValue: CGFloat = 5000
    @State private var minPriceColor: Color = .textGrey
    
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Color.white
                            .ignoresSafeArea(edges: .bottom)
                        VStack {
                            categoryView
                            pricesView
                            colorsView
                        }
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Constants.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: Constants.backButtonIcon)
                        }
                        .tint(.white)
                    }
                }
        }
    }
    
    // Category
    
    private var categoryView: some View {
        VStack(alignment: .leading, spacing: 0) {
            categoryHeaderView
            categoryScrollView
        }.padding()
    }
    
    private var categoryHeaderView: some View {
        HStack {
            Text(Constants.category)
                .frame(width: 175, height: 30)
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.textGrey)
            Spacer()
            HStack {
                Text(Constants.more)
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.lightGray)
                
                Button {
                    
                } label: {
                    Image(systemName: Constants.detailButtonIcon)
                        .foregroundColor(.lightGray)
                }
            }
        }.padding(30)
    }
    
    private var categoryScrollView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows)  {
                ForEach(0..<filtersViewModel.categories.count) { index in
                    ZStack {
                        Color.categoryBackground
                            .frame(width: 120, height: 80)
                            .cornerRadius(10)
                        Image(filtersViewModel.categories[index].image)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }.shadow(
                        radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -2, y: 5
                    )
                }
            }
        }
        .scrollIndicators(.never)
    }
    
    // Prices
    
    private var pricesView: some View {
        ZStack {
            VStack(alignment: .leading) {
                pricesHeaderView
                VStack(alignment: .leading, spacing: 0) {
                    pricesSliderView
                    pricesFooterView
                }
            }.padding()
            
            Text("$\(Int(maxValue))")
                .frame(width: 80, height: 24)
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.textGrey)
                .offset(
                    x: filtersViewModel.positionValue,
                    y: 35
                )
        }
    }
    
    private var pricesHeaderView: some View {
        Text(Constants.prices)
            .frame(width: 175, height: 30)
            .font(.system(size: 24))
            .bold()
            .foregroundColor(.textGrey)
    }
    
    private var pricesSliderView: some View {
        Slider(value: Binding(get: {
            filtersViewModel.sliderValue
        }, set: { newValue in
            filtersViewModel.sliderValue = newValue
            filtersViewModel.getPosition(for: newValue)
            maxValue = newValue
            updatePricePositionAppearance(newValue)
        }), in: 500...5000, step: 500) { _ in
            
        }
        .accentColor(.sliderCircle)
        .onAppear {
            let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
            UISlider.appearance()
                .setThumbImage(
                    UIImage(systemName: "circle.fill",
                            withConfiguration: progressCircleConfig
                           ), for: .normal)
        }
    }
    
    private var pricesFooterView: some View {
        Text(Constants.minPrice)
            .frame(width: 60, height: 24)
            .font(.system(size: 18))
            .bold()
            .foregroundColor(minPriceColor)
        
    }
    
    // Colors
    
    private var colorsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            colorsHeaderView
            colorLazyVGrid
        }.padding()
    }
    
    private var colorsHeaderView: some View {
        Text("\(Constants.color) \(filtersViewModel.selectedColor)")
            .frame(width: 175, height: 30)
            .font(.system(size: 24))
            .bold()
            .foregroundColor(.textGrey)
    }
    
    private var colorLazyVGrid: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<filtersViewModel.colorCircles.count) { index in
                
                makeColorCircleView(
                    colorCircle: filtersViewModel
                        .colorCircles[index]
                )
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func makeColorCircleView(
        colorCircle: ColorCircle
    ) -> some View {
        
        Button {
            filtersViewModel.updateSelectedColor(colorCircle.id)
        } label: {
            Color(colorCircle.color)
                .frame(width: 40, height: 40)
                .border(Color.sliderNotSelected, width: 1)
                .cornerRadius(20)
        }
        
    }
    
    
    private func updatePricePositionAppearance(_ position: CGFloat) {
        minPriceColor = filtersViewModel.sliderValue > 1500
        ? .textGrey
        : .white
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

#Preview {
    FiltersView()
}
