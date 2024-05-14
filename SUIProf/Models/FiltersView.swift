//
//  FiltersView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI
/// Экран настройки фильтров
struct FiltersView: View {

    enum Constants {
        static let titleText = "Filters"
        static let categoryText = "Category"
        static let moreText = "More"
        static let pricesText = "Prices"
        static let colorText = "Color"
        static let verdanaFont = "Verdana"
        static let arrowRightImageName = "chevron.right"
        static let barBackButtonImage = "chevron.left"
        static let minPriceText = "500$"
    }

    let columnsTypeFilters: [GridItem] = [
        .init(.fixed(120))
    ]

    let columnsColorsFilters: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]

    var sourceColors: [Color] = [
        .white, .black, .gray, .purple, .orange,
        .red, .green, .blue, .pink, .yellow,
        .brown, .cyan, .indigo, .mint, .teal,
        .red, .green, .blue, .pink, .yellow,
    ]

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            getNavigationBar()
            HStack {
                Text(Constants.categoryText)
                    .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
                Text(Constants.moreText)
                    .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                    .foregroundStyle(.appLightGray)
                Image(systemName: Constants.arrowRightImageName)
                    .foregroundStyle(.appLightGray)
                    .padding(.trailing)
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: columnsTypeFilters) {
                    ForEach(viewModel.sourceTypes.indices, id: \.self) { indexImage in
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .overlay {
                                Image(viewModel.sourceTypes[indexImage])
                            }
                            .frame(width: 120, height: 80)
                            .foregroundStyle(.appLightGray3)
                            .shadow(radius: 2, y: 2)
                            .padding(.leading)
                    }
                }
            }
            .padding(.horizontal)
            HStack {
                Text(Constants.pricesText)
                    .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
            }
            Slider(value: Binding(
                get: { Double(self.price) },
                set: { newValue in
                    self.price = Int(newValue)
                }
            ), in: 500...5000, step: 500) {
                Text(String(price))
            } onEditingChanged: { newValue in
                print(newValue)
            }.onChange(of: price) { newValue in
                print(newValue)
            }
                .padding(.horizontal)
                .tint(.green)
                .colorMultiply(.gray)
                .onAppear {
                    UISlider.appearance().setThumbImage(UIImage(named: "slider"), for: .normal)
                }
            HStack {
                Text(Constants.minPriceText)
                    .font(.custom(Constants.verdanaFont, size: 15))
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
                Text("\(Int(price))$")
                    .font(.custom(Constants.verdanaFont, size: 15))
                    .foregroundStyle(price == 500 ? .clear : .appGray)
                    .padding(.horizontal)
                    .offset(x: getOffsetPriceSlider())
            }
            HStack {
                Text(colorTitle)
                    .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
            }
            if #available(iOS 17.0, *) {
                LazyVGrid(columns: columnsColorsFilters) {
                    ForEach(sourceColors.indices, id: \.self) { indexColor in
                        Circle()
                            .stroke(.black)
                            .fill(sourceColors[indexColor])
                            .padding(.horizontal)
                            .onTapGesture {
                                colorTitle = "Color - \(sourceColors[indexColor])"
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarItems(
            leading:
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: Constants.barBackButtonImage)
                        .foregroundStyle(.white)
                })
            , trailing:
                Text("")
        )
        .navigationBarBackButtonHidden(true)
        Spacer()
    }

    @State private var colorTitle: String = Constants.colorText
    @State private var price: Int = 500
    @State private var priceSliderColor: Color = .white

    private func getNavigationBar() -> some View {
        ZStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
            VStack {
                Spacer()
                    .frame(height: 50)
                Text(Constants.titleText)
                    .foregroundStyle(.white)
                    .font(.bold(.custom(Constants.verdanaFont, size: 20))())
            }
        }
        .ignoresSafeArea()
        .frame(height: 30)
    }

    private func getOffsetPriceSlider() -> CGFloat {
        let offset = price < 4500 ? 33 : 30
        return -CGFloat((10 - (price/500))) * CGFloat(offset)
    }
}
