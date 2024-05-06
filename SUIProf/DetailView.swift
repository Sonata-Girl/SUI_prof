//
//  DetailView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

struct DetailView: View {

    enum Constants {
        static let titleText = "Sofa Elda 900"
        static let fontVerdanaBold = "Verdana-Bold"
        static let fontVerdana = "Verdana"
        static let price = "Price: 999$"
        static let imageName = "sofa"
        static let articleText = "Article: 283564"
        static let descriptionText = "Description: A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design. "
        static let nothingText = "Nothing yet"
        static let reviewText = "Review"
        static let textButtonBuyText = "Buy now"
        static let countText = "/300"
    }

   @State private var reviewText = Constants.nothingText

    var body: some View {
        VStack {
            HStack {
                Text(Constants.titleText)
                    .font(.bold(.custom(Constants.fontVerdanaBold, size: 20))())
                    .padding()
                Spacer()
                Image(systemName: "heart")
                    .padding()
            }
            Image(Constants.imageName)
            HStack{
                Spacer()
                if #available(iOS 16.0, *) {
                    UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 10, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .continuous)
                        .frame(width: 191, height: 44)
                        .foregroundStyle(.appLightBrown)
                        .overlay(alignment: .center) {
                            Text(Constants.price)
                                .font(.custom(Constants.fontVerdanaBold, size: 20))
                        }
                } else {
                    // Fallback on earlier versions
                }
            }
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .foregroundStyle(.linearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text(Constants.articleText)
                            .font(.bold(.custom(Constants.fontVerdana, size: 16))())
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 30, leading: 20, bottom: 5, trailing: 20))
                        Spacer()
                    }
                    Text(Constants.descriptionText)
                        .font(.custom(Constants.fontVerdana, size: 16))
                        .foregroundStyle(.white)

                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    HStack {
                        Spacer()
                        Text(Constants.reviewText)
                            .font(.bold(.custom(Constants.fontVerdana, size: 16))())
                            .foregroundStyle(.white)
                            .padding()
                        Spacer()
                    }.padding(.horizontal)
                    HStack {
//                        if #available(iOS 16.0, *) {
                            TextEditor(text: $reviewText)
                                .font(.custom(Constants.fontVerdana, size: 16))
                                .frame(width: 285, height: 177)
                            //                        .foregroundStyle(.clear)
//                                .backgroundStyle(.linearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom))
                                .background(.appGreen.opacity(0.5))
                                .padding(.zero)
                            Text("\(reviewText.count)\(Constants.countText)")
                                .frame(width: 60, height: 17)
                                .foregroundStyle(.white)
                                .padding(.zero)
//                        }
                    }.padding(.horizontal)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text(Constants.textButtonBuyText)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .foregroundStyle(.linearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom))
                            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                    }
                    .background(.white)
                    .frame(width: 305, height: 55, alignment: .center)
                    .clipShape(.capsule)
                }
            } .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

