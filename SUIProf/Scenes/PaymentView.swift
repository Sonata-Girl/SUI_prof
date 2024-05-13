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
        static let cvcIsShortText = "CVC должен содержать 3 символа."
        static let thanksText = "Спасибо!"
        static let cardAddedText = "Карта добавлена успешно"
        static let month = "Month"
        static let year = "Year"
        static let cardNumber = "**** **** **** 0000"
        static let nameText = "Your Name"
        static let cardHolderTitle = "Cardholder"
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
        ScrollView {
            ZStack() {
                CardView(cardNumber: $cardNumber, nameText: $nameCardholder)
                    .modifier(FlipOpacity(percentage: showBackCard ? 0 : 1))
                    .rotation3DEffect(Angle.degrees(showBackCard ? 180 : 360), axis: (0,1,0))
                BackCardView(cardNumber: $newCardNumberTextField, cvcNumber: $cvcTextField, date: $dateCard)
                    .modifier(FlipOpacity(percentage: showBackCard ? 1 : 0))
                    .rotation3DEffect(Angle.degrees(showBackCard ? 0 : 180), axis: (0,1,0))
            }
            .onTapGesture {
                withAnimation {
                    self.showBackCard.toggle()
                }
            }

            VStack(alignment: .leading) {
                getTitleText(title: Constants.addNewCardText)
                TextField(Constants.addNewCardText, text: $newCardholderTextField)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: newCardholderTextField) { newValue in
                        newCardholderTextField = newValue
                        withAnimation(.linear) {
                            nameCardholder = newCardholderTextField
                        }
                    }
                Divider()
                    .frame(width: 350)
                    .padding(.leading)
            }
            VStack(alignment: .leading) {
                getTitleText(title: Constants.cardNumberTitle)
                TextField(Constants.cardNumberTitle, text: $newCardNumberTextField)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: newCardNumberTextField) { newValue in
                        newCardNumberTextField = viewModel.formatNumber(numberCard: newValue)
                        if newCardNumberTextField.count > 14 {
                            withAnimation(.linear) {
                                cardNumber = "**** **** **** \(newCardNumberTextField.suffix(4))"
                            }
                        } else {
                            cardNumber = newCardNumberTextField
                        }
                    }
                    .keyboardType(.numberPad)
                Divider()
                    .frame(width: 350)
                    .padding(.leading)
            }
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(Constants.month)
                            .font(.custom(Constants.verdanaFont, size: 20))
                            .foregroundStyle(.appGray)
                        Spacer()
                        Picker(selection: $dateSelection) {
                            ForEach (1...12, id: \.self) {Text("\($0)").tag("\($0)")}
                        } label: {
                            Text(Constants.month)
                        }
                        .pickerStyle(.menu)
                        .onChange(of: dateSelection) { newValue in
                            dateSelection = newValue
                            month = String(dateSelection)
                            dateCard = "\(month)/\(year)"
                        }
                    }
                    Divider()
                }
                .tint(.appGray)
                VStack(alignment: .leading) {
                    HStack {
                        Text(Constants.year)
                            .font(.custom(Constants.verdanaFont, size: 20))
                            .foregroundStyle(.appGray)
                            .padding(.leading)
                        Picker(selection: $yearSelection) {
                            ForEach (0...10, id: \.self) {Text(String(2024 + $0)).tag(String(2024 + $0))}
                        } label: {
                            Text(Constants.year)
                        }
                        .pickerStyle(.menu)
                        .onChange(of: yearSelection) { newValue in
                            yearSelection = newValue
                            year = String(24 + yearSelection)
                            dateCard = "\(month)/\(year)"
                        }
                    }
                    Divider()
                        .padding(.trailing)
                }
                .tint(.appGray)
            }
            .padding(.horizontal)
            getCvcFieldsBlock(
                title: Constants.cvcTitle,
                text: Constants.cvcText
            )
        }
            Spacer()
            getButton()
                .shadow(radius: 3, y: 1)
    }

    @State private var cvcIsShow = false
    @State private var cvcTextField = Constants.cvcText
    @State private var newCardholderTextField = Constants.cardHolderNameText
    @State private var newCardNumberTextField = Constants.cardNumberText
    @State private var cvcIsShortAlert = false
    @State private var successAlert = false
    @State private var showBackCard = false
    @State private var yearSelection = 0
    @State private var dateSelection = 0
    @State var cardNumber: String = Constants.cardNumber
    @State var nameCardholder: String = Constants.nameText
    @State var year: String = ""
    @State var month: String = ""
    @State var dateCard: String = ""

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
            getTitleText(title: title)
            if cvcIsShow {
                TextField(Constants.cvcTitle, text: $cvcTextField)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: cvcTextField) { newValue in
                        withAnimation {
                            cvcTextField = viewModel.cutString(text: newValue, maxCount: 3)
                        }
                    }
            } else {
                SecureField(Constants.cvcTitle, text: $cvcTextField)
                    .textContentType(.password)
                    .font(.custom(Constants.verdanaFont, size: 20))
                    .foregroundStyle(.appGray)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
                    .onChange(of: cvcTextField) { newValue in
                        withAnimation {
                            cvcTextField = viewModel.cutString(text: newValue, maxCount: 3)
                        }
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

    private func getTitleText(title: String) -> some View {
        HStack {
            Text(title)
                .padding(.top)
                .padding(.leading)
                .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                .foregroundStyle(.appGray)
            Spacer()
        }
    }

    private func getButton() -> some View {
        Button {
            if cvcTextField.count < 3 {
                cvcIsShortAlert = true
            } else {
                successAlert = true
            }
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
        .alert(isPresented: $cvcIsShortAlert) {
            Alert(title: Text("Ошибка"), message: Text(Constants.cvcIsShortText))
         }
        .alert(isPresented: $successAlert) {
            Alert(title: Text(Constants.cardAddedText), message: Text(Constants.thanksText))
        }
    }
}

private struct FlipOpacity: AnimatableModifier {
    var percentage: CGFloat = 0

    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }

    func body(content: Content) -> some View {
        content
            .opacity(Double(percentage.rounded()))
    }
}
