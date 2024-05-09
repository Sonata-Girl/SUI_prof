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

            Slider(value: $price, in: Float(500)...Float(5000), step: 500)
                .padding(.horizontal)
                .tint(.green)
                .colorMultiply(.gray)
            //                .overlay(GeometryReader { gp in
            //                    Text("\(Int(price))$").foregroundStyle(.appGray)
            //                        .frame(maxWidth: .infinity, alignment: .leading)
            //                        .font(.custom(Constants.verdanaFont, size: 15))
            //                        .offset(x: -30, y: 50)
            //                        .alignmentGuide(HorizontalAlignment.leading) { $0[HorizontalAlignment.leading] - (gp.size.width - $0.width) * price / (Float(5000) - Float(500))
            //                        }

            //                }, alignment: .bottom)
                .onAppear {
                    UISlider.appearance().setThumbImage(UIImage(named: "circle"), for: .normal)
                }
            HStack {
                Text(Constants.minPriceText)
                    .font(.custom(Constants.verdanaFont, size: 15))
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
                Text("\(Int(price))$")
                    .font(.custom(Constants.verdanaFont, size: 15))
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
            }

            //            .padding(.horizontal)
            HStack {
                Text(colorTitle)
                    .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                    .foregroundStyle(.appGray)
                    .padding(.horizontal)
                Spacer()
            }
            if #available(iOS 17.0, *) {
                LazyVGrid(columns: columnsColorsFilters) {
                    ForEach(viewModel.sourceColors.indices, id: \.self) { indexColor in
                        Circle()
                            .stroke(.black)
                            .fill(viewModel.sourceColors[indexColor])
                            .padding(.horizontal)
                            .onTapGesture {
                                colorTitle = "Color - \(viewModel.sourceColors[indexColor])"
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
    @State private var price: Float = 0

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
        .frame(height: 60)
    }
}
