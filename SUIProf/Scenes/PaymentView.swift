//
//  PaymentView.swift
//  SUIProf
//
//  Created by Sonata Girl on 10.05.2024.
//

import SwiftUI
/// Экран настройки оплаты
struct PaymentView: View {

    enum Constants {
        static let titleText = "Payment"
        static let verdanaFont = "Verdana"
        static let barBackButtonImage = "chevron.left"
        static let addNewCardText = "Add new card"
        static let cardHolderNameText = "Cardholder name"
        static let cardNumberTitle = "Card number"
        static let cardNumberText = "0000 0000 0000 0000"
        static let cvcTitle = "CVC"
        static let cvcText = "000"
        static let addNowText = "Add now"

    }

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
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
        }
        .ignoresSafeArea()
        .frame(height: 30)
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
        CardView()
        getTextBlock(
            title: Constants.addNewCardText,
            text: Constants.cardHolderNameText
        )
        getTextBlock(
            title: Constants.cardNumberTitle,
            text: Constants.cardNumberText
        )
        getCvcFieldsBlock(
            title: Constants.cvcTitle,
            text: Constants.cvcText
        )
        Spacer()
        getButton()
            .shadow(radius: 3, y: 1)
    }

    @State private var cvcIsShow = false
    @State private var cvcTextFieldText = Constants.cvcText

    private func getTextBlock(title: String,text: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.top)
                    .padding(.leading)
                    .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                    .foregroundStyle(.appGray)
                Spacer()
            }
            Text(text)
                .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                .font(.custom(Constants.verdanaFont, size: 20))
                .foregroundStyle(.appGray)
            Divider()
                .frame(width: 350)
                .padding(.leading)
        }
    }

    private func getCvcFieldsBlock(title: String,text: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.top)
                    .padding(.leading)
                    .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                    .foregroundStyle(.appGray)
                Spacer()
            }
            if cvcIsShow {
                TextField(Constants.cvcTitle, text: $cvcTextFieldText)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: cvcTextFieldText) { newValue in
                        cvcTextFieldText = newValue
                    }
            } else {
                SecureField(Constants.cvcTitle, text: $cvcTextFieldText)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: cvcTextFieldText) { newValue in
                        cvcTextFieldText = newValue
                    }
            }

            Divider()
                .frame(width: 350)
                .padding(.leading)
        }
        .overlay(alignment: .trailing) {
            Button {
                cvcIsShow.toggle()
            } label: {
                Image(systemName: cvcIsShow ? "eye" : "eye.slash")
                    .foregroundStyle(.black)
            }
            .padding()
        }
    }

    private func getButton() -> some View {
        Button {

        } label: {
            LinearGradient(
                gradient: Gradient(colors: [
                    .appLightGreen,
                    .appGreen
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .overlay(alignment: .center) {
                Text(Constants.addNowText)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
        }
        .frame(width: 300, height: 55)
        .tint(.white)
        .background(.white)
        .font(.bold(.custom(Constants.verdanaFont, size: 20))())
        .cornerRadius(30)
        .padding()
        //        .alert(isPresented: $passwordIsShortAlert) {
        //            Alert(title: Text("Ошибка"), message: Text(Constants.passwordIsShortText))
        //        }
    }
}

