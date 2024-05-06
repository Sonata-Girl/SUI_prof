//
//  StartView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

struct StartView: View {

    enum Constants {
        static let appName = "169.ru"
        static let fontVerdana = "Verdana"
        static let imageLogoName = "logo"
        static let getStartedTExt = "Get Started"
        static let questionText = "Don't have an account?"
        static let signText = "Sing in here"
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 175/255, green: 224/255, blue: 197/255),
                    Color(red: 50/255, green: 75/255, blue: 53/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack {
                Spacer()
                    .frame(height: 50)
                Text(Constants.appName)
                    .font(.bold(.custom(Constants.fontVerdana, size: 40))())
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
                    .frame(height: 50)
                Image(Constants.imageLogoName)
                    .frame(width: 296, height: 121, alignment: .center)
                    .padding()
                Spacer()
                    .frame(height: 130)
                Button {

                } label: {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .orange,
                            .white
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .overlay(alignment: .center) {
                        Text(Constants.getStartedTExt)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                }
                .frame(width: 300, height: 55)
                .tint(.black)
                .background(.white)
                .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                .cornerRadius(30)
                .padding()
                Spacer()
                    .frame(height: 70)
                Text(Constants.questionText)
                    .font(.bold(.custom(Constants.fontVerdana, size: 16))())
                    .foregroundStyle(.white)
                    .padding()
                Text(Constants.signText)
                    .font(.bold(.custom(Constants.fontVerdana, size: 28))())
                    .foregroundStyle(.white)
                    .padding(.zero)
                Divider()
                    .frame(width: 200, height: 5, alignment: .center)
                    .padding(.zero)
                    .foregroundStyle(.white)
            }
        }.ignoresSafeArea()
    }
}
