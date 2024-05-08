//
//  GoodsView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI
/// Экран списка товаров
struct GoodsView: View {

    enum Constants {
        static let searchTextPlaceholder = "Search..."
        static let filterImageName = "filter"
        static let verdanaFont = "Verdana"
        static let totalPriceTitle = "Your total price"
        static let searchImageName = "magnifyingglass"

    }

    @EnvironmentObject var viewModel: AppViewModel
    @State private var searchText = ""

    var body: some View {
        VStack {
            getNavigationBar()
            getPriceWindow()
            ScrollView {
                ForEach(viewModel.goods.indices, id: \.self) { goodIndex in
                    GoodCellView(good: viewModel.goods[goodIndex],
                                 indexGood: goodIndex)
                    .environmentObject(viewModel)
                }
            }
            .padding(.top)
            if viewModel.goods.count == 0 {
                Spacer()
            }
        }
    }

    private func getNavigationBar() -> some View {
        VStack {
            ZStack {
                LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                            .foregroundStyle(.white)
                            .overlay(alignment: .leading) {
                                HStack {
                                    Image(systemName: Constants.searchImageName)
                                        .foregroundStyle(.appLightGray)
                                        .padding(.leading)
                                    TextField(text: $searchText) {
                                        Text(Constants.searchTextPlaceholder)
                                    }
                                }
                                .padding(.zero)
                            }
                            .frame(width: 312, height: 48)
                            .padding(.leading)
                        Button(action: {

                        }, label: {
                            Image(Constants.filterImageName)
                                .padding(.trailing)
                        })
                    }
                    .padding(.vertical)
                }
            }
        }
        .ignoresSafeArea()
        .frame(height: 90)
    }

    private func getPriceWindow() -> some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundStyle(.appLightGreen)
                .frame(width: 350, height: 48)
                .padding(.trailing, -10)
                .padding(.top)
                .overlay(alignment: .center) {
                    HStack {
                        Text("\(Constants.totalPriceTitle)")
                            .font(.custom(Constants.verdanaFont, size: 24))
                            .foregroundStyle(.appGray)
                            .padding(.top)
                            .padding(.trailing)
                        Text("\(viewModel.goods.map {$0.price * $0.count}.reduce(0,+))$")
                            .font(.bold(.custom(Constants.verdanaFont, size: 24))())
                            .foregroundStyle(.appGray)
                            .padding(.top)
                    }
                }
        }
    }
}
