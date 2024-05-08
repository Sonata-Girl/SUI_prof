//
//  GoodCellView.swift
//  SUIProf
//
//  Created by Sonata Girl on 08.05.2024.
//

import SwiftUI
/// Вью для ячейки товара
struct GoodCellView: View {
    var good: Good
    var indexGood : Int
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingSheet = false

    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .overlay(alignment: .leading) {
                Image(good.imageName)
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding()
            }
            .frame(width: 360, height: 150)
            .foregroundStyle(.appLightGreen3)
            .shadow(color: .appGray, radius: 1, y: 1)
            .overlay(alignment: .trailing) {
                VStack {
                    Text(good.goodName)
                        .font(.bold(.custom("Verdana", size: 22))())
                        .foregroundStyle(.appGray)
                    HStack(spacing: 10){
                        Text("\(good.price)$")
                            .font(.bold(.custom("Verdana", size: 24))())
                            .foregroundStyle(.appLightGreen)
                        Text("\(good.oldPrice)$")
                            .strikethrough()
                            .font(.custom("Verdana", size: 24))
                            .foregroundStyle(.appGray)
                    }
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .foregroundStyle(.appLightGreen1)
                        .overlay(alignment: .center) {
                            HStack(spacing: 20) {
                                Button(action: {
                                    if good.count > 0 {
                                        viewModel.decreaseCountToGood(index: indexGood)
                                    }
                                }, label: {
                                    Text("-")
                                        .font(.bold(.custom("Verdana", size: 18))())
                                        .foregroundStyle(.appGray)
                                })
                                Text(String(good.count))
                                    .font(.bold(.custom("Verdana", size: 18))())
                                    .foregroundStyle(.appGray)
                                Button(action: {
                                    viewModel.increaseCountToGood(index: indexGood)
                                }, label: {
                                    Text("+")
                                        .font(.bold(.custom("Verdana", size: 18))())
                                        .foregroundStyle(.appGray)
                                })
                            }
                        }
                        .frame(width: 115, height: 40)
                }
                .padding(.zero)
                .frame(width: 210)
            }
            .fullScreenCover(isPresented: $showingSheet, content: DetailView.init)
            .environmentObject(viewModel)
            .onTapGesture {
                viewModel.currentIndexGood = indexGood
                showingSheet = true
            }
    }
}
