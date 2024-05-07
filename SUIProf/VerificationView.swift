//
//  VerificationView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI
/// Экран получения кода верификации
struct VerificationView: View {

    enum Constants {
        static let barBackButtonImage = "chevron.left"
        static let checkScreenImage = "checkLogo"
        static let verificationCodeText = "Verification code"
        static let checkSMSText = "Check the SMS"
        static let messageText = "message to get verification code"
        static let didntReceivedSmsText = "Didn’t receive sms"
        static let sendSMSText = "Send sms again"
        static let verdanaFont = "Verdana"
        static let buttonText = "Continue"
        static let titleText = "Verification"
        static let fillSMSText = "Fill in from message"
    }

    /// Типы текстфилдов
    private enum TextFields {
        case one, two, three, four
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
        Spacer()
        VStack {
            Image(Constants.checkScreenImage)
            Text(Constants.verificationCodeText)
                .font(.custom(Constants.verdanaFont, size: 20))
                .foregroundStyle(.appGray)
            HStack {
                Spacer()
                TextField("", text: $oneTextField)
                .codesTextField()
                .focused($currentTextField, equals: .one)
                .onSubmit {
                    currentTextField = .two
                }
                .onChange(of: oneTextField) { newValue in
                    oneTextField = newValue
                    if oneTextField.count == 1 {
                        currentTextField = .two
                    } else {
                        currentTextField = nil
                    }
                }
                TextField("", text: $twoTextField)
                .codesTextField()
                .focused($currentTextField, equals: .two)
                .onSubmit {
                    currentTextField = .three
                }
                .onChange(of: twoTextField) { newValue in
                    twoTextField = newValue
                    if twoTextField.count == 1 {
                        currentTextField = .three
                    } else {
                        currentTextField = .one
                    }
                }
                TextField("", text: $threeTextField)
                .codesTextField()
                .focused($currentTextField, equals: .three)
                .onSubmit {
                    currentTextField = .four
                }
                .onChange(of: threeTextField) { newValue in
                    threeTextField = newValue
                    if threeTextField.count == 1 {
                        currentTextField = .four
                    } else {
                        currentTextField = .two
                    }
                }
                TextField("", text: $fourTextField)
                .font(.custom(Constants.verdanaFont, size: 40))
                .padding(.vertical)
                .frame(width: 60, height: 70)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.appGray)
                .multilineTextAlignment(.center)
                .focused($currentTextField, equals: .four)
                .onSubmit {
                    currentTextField = nil
                }
                .onChange(of: fourTextField) { newValue in
                    fourTextField = newValue
                    if fourTextField.count == 1 {
                        currentTextField = nil
                    } else {
                        currentTextField = .three
                    }
                }
                Spacer()
            }
            Text(Constants.checkSMSText)
                .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                .foregroundStyle(.appGray)
            Text(Constants.messageText)
                .font(.custom(Constants.verdanaFont, size: 16))
                .foregroundStyle(.appGray)
            ProgressView("Loading: \(progress)/100", value: Double(progress), total: 100)
                .frame(width: 150)
                .padding(.horizontal)
                .foregroundStyle(.appGray)
                .accentColor(.appLightGreen)
            getButton()
            Text(Constants.didntReceivedSmsText)
                .font(.custom(Constants.verdanaFont, size: 20))
                .foregroundStyle(.appGray)
                .padding(.zero)
            Button(action: {
                randomNumber = String(Int.random(in: 1000...9999))
                sendSmsAlertShow = true
            }, label: {
                Text(Constants.sendSMSText)
                    .font(.bold(.custom(Constants.verdanaFont, size: 20))())
                    .foregroundStyle(.appGray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .alert(isPresented: $sendSmsAlertShow) {
                Alert(
                    title: Text(Constants.fillSMSText),
                    message: Text(randomNumber),
                    primaryButton: .cancel(),
                    secondaryButton: .default(Text("Ok"), action: {
                        fillTextFields()
                    }))
            }
            .frame(width: 300, height: 30)
            .padding(.zero)
            Divider()
                .frame(width: 160)
                .foregroundStyle(.appGray)
            Spacer()
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
    }

    @FocusState private var currentTextField: TextFields?
    @State private var sendSmsAlertShow = false
    @State private var oneTextField = ""
    @State private var twoTextField = ""
    @State private var threeTextField = ""
    @State private var fourTextField = ""
    @State private var progress = 0
    @State private var randomNumber = ""


    private func getButton() -> some View {
        Button {
            if progress + 20 > 100 {
                progress = 100
            } else {
                progress += 20
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
                Text(Constants.buttonText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(width: 300, height: 55)
        .tint(.white)
        .font(.bold(.custom(Constants.verdanaFont, size: 20))())
        .cornerRadius(30)
        .padding()
    }

    private func fillTextFields() {
        oneTextField = String(randomNumber.removeFirst())
        twoTextField = String(randomNumber.removeFirst())
        threeTextField = String(randomNumber.removeFirst())
        fourTextField = String(randomNumber.removeFirst())
    }
}
