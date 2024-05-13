//
//  BackCardView.swift
//  SUIProf
//
//  Created by Sonata Girl on 10.05.2024.
//

import SwiftUI
/// Вью отображения  обратной стороны карты оплаты
struct BackCardView: View {

    @Binding var cardNumber: String
    @Binding var cvcNumber: String
    @Binding var date: String

    enum Constants {
        static let verdanaFont = "Verdana"
        static let cardNumber = "0000 0000 0000 0000"
        static let cvcNumber = "991"
        static let cvcText = "CVC/CVV"
        static let dateText = "01/28"
        static let validText = "Valid"
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .frame(width: 310, height: 180)
                .shadow(radius: 3)
                .foregroundStyle(.linearGradient(colors: [.appLightGreen,.appGreen], startPoint: .leading, endPoint: .trailing))

                .overlay(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(cardNumber)
                            .padding(.top)
                            .padding(.leading)
                            .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                            .foregroundStyle(.white)
                        HStack {
                            Text(cvcNumber)
                                .padding(.top)
                                .padding(.leading)
                                .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                                .foregroundStyle(.white)
                            Text(Constants.cvcText)
                                .padding(.leading)
                                .font(.custom(Constants.verdanaFont, size: 16))
                                .foregroundStyle(.appLightGray)
                                .padding(.top)
                        }
                        HStack {
                            Text(date)
                                .padding(.top)
                                .padding(.leading)
                                .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                                .foregroundStyle(.white)
                            Text(Constants.validText)
                                .padding(.leading)
                                .font(.custom(Constants.verdanaFont, size: 16))
                                .foregroundStyle(.appLightGray)
                                .padding(.top)
                        }
                    }
                }
        }
    }
}

