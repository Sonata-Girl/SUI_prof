//
//  ContentView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AppViewModel()

    var body: some View {
//        StartView()
//        ProfileView()
//        GoodCellView(good: Binding(get: {
//            Good(imageName: "thirdGood", goodName: "Bed", price: 1000, oldPrice: 2000, count: 0)
//        }, set: { newValue in
//            print()
//        }))
//        GoodsView()
//            .environmentObject(viewModel)
        FiltersView()
    }
}

#Preview {
    ContentView()
}

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

    let sourceTypes: [String] = [
        "filterBed",
        "filterSofa",
        "filterChair"
    ]

    let sourceColors: [Color] = [
        .white,
        .black,
        .gray,
        .purple,
        .orange,
        .red,
        .green,
        .blue,
        .pink,
        .yellow,
    ]

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var viewModel: AppViewModel
    @State private var colorTitle: String = Constants.colorText
    @State private var price: Int = 0

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
                    ForEach(sourceTypes.indices, id: \.self) { indexImage in
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .overlay {
                                Image(sourceTypes[indexImage])
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
//                    self.viewModel.setNewCarSettings(
//                        oldValue: self.setCar,
//                        value: Int(newValue)
//                    )
                    self.price = Int(newValue)
                }
            ), in: 500...5000, step: 500) {
                Text(String(price))
            } onEditingChanged: { newValue in
                print(newValue)
            }
            .padding(.horizontal)
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
