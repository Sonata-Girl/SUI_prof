//
//  CardView.swift
//  SUIProf
//
//  Created by Sonata Girl on 10.05.2024.
//

import SwiftUI
/// Вью отображения карты оплаты
struct CardView: View {

    enum Constants {
        static let verdanaFont = "Verdana"
        static let mirImageName = "mir"
        static let cardNumber = "**** **** **** 0000"
        static let cardNumberTitle = "Card number"
        static let nameText = "Your Name"
        static let cardHolderTitle = "Cardholder"
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .frame(width: 310, height: 180)
                .shadow(radius: 3)
                .foregroundStyle(.linearGradient(colors: [.appLightGreen,.appGreen], startPoint: .leading, endPoint: .trailing))

                .overlay(alignment: .topTrailing) {
                    Image(Constants.mirImageName)
                        .padding(.top)
                        .padding(.trailing)
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(Constants.cardNumber)
                            .padding(.top)
                            .padding(.leading)
                            .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                            .foregroundStyle(.white)
                        Text(Constants.cardNumberTitle)
                            .padding(.leading)
                            .font(.custom(Constants.verdanaFont, size: 16))
                            .foregroundStyle(.appLightGray)
                        Text(Constants.nameText)
                            .padding(.leading)
                            .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                            .foregroundStyle(.white)
                            .padding(.top)
                        Text(Constants.cardHolderTitle)
                            .padding(.bottom)
                            .padding(.leading)
                            .font(.custom(Constants.verdanaFont, size: 16))
                            .foregroundStyle(.appLightGray)
                    }
                }
        }
    }
}


