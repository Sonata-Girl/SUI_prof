//
//  LoginView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

/// Экран авторизации
struct LoginView: View {

    enum Constants {
        static let loginText = "Log in"
        static let fontVerdana = "Verdana"
        static let inputPhoneText = "Введите телефон"
        static let inputPassText = "Введите пароль"
        static let signUpText = "Sign up"
        static let forgotPasswordText = "Forgot your password?"
        static let checkText = "Check Verification"
        static let passwordIsShortText = "Пароль должен содержать от 6 до 15 символов."
        static let supportPhoneTitle = "Телефон техподдержки"
        static let supportPhoneText = "5-555-555-555"
    }

    /// Типы текстфилдов
    private enum TextFields {
        /// Для ввода телефона
        case phone
        /// Для ввода пароля
        case password
    }

    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            ZStack {
                LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
            }
        }
        .ignoresSafeArea()
        .frame(height: 40)
        VStack {
            getSegmentedView()
            Spacer()
                .frame(height: 90)
            getPhonePasswordBlock()
            Spacer()
                .frame(height: 70)
            getButton()
            Button {
                supportPhoneShowOn = true
            } label: {
                Text(Constants.forgotPasswordText)
                    .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                    .foregroundStyle(.appGray)
            }
            .padding(.top)
            .alert(isPresented: $supportPhoneShowOn) {
                Alert(title: Text(Constants.supportPhoneTitle),message: Text(Constants.supportPhoneText))
            }
            NavigationLink {
                VerificationView()
                    .environmentObject(viewModel)
            } label: {
                Text(Constants.checkText)
                    .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                    .foregroundStyle(.appGray)
                    .padding(.zero)
            }
            .padding(.top)
            Divider()
                .frame(width: 160, height: 1)
                .foregroundStyle(.appGray)
            Spacer()
        }
        .background(.clear)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarBackButtonHidden()
    }

    @State private var phoneTextField = ""
    @State private var passwordTextField = ""
    @State private var passwordIsShow = false
    @State private var passwordIsShortAlert = false
    @State private var supportPhoneShowOn = false
    @FocusState private var currentTextField: TextFields?
    @State private var showingSheet = false
    @State var shakePasswordField = false

    private func getSegmentedView() -> some View {
        HStack(alignment: .center) {
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 30,
                    bottomLeading: 30,
                    bottomTrailing: 0,
                    topTrailing: 0),
                                       style: .continuous)
                .stroke(Color.appLightGray)
                .frame(width: 148, height: 51)
                .foregroundStyle(.white)
                .overlay(alignment: .center) {
                    Text(Constants.loginText)
                        .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                        .foregroundStyle(.linearGradient(colors: [.appGreen, .appLightGreen], startPoint: .top, endPoint: .bottom))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -5))
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: 30,
                    topTrailing: 30),
                                       style: .continuous)
                    .frame(width: 148, height: 51)
                    .foregroundStyle(.appLightGray)
                    .overlay(alignment: .center) {
                        Text(Constants.signUpText)
                            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                            .foregroundStyle(.linearGradient(colors: [.appGreen, .appLightGreen], startPoint: .top, endPoint: .bottom))
                    }
                    .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
            } else {
                // Fallback on earlier versions
            }
        }
    }

    private func getPhonePasswordBlock() -> some View {
        VStack {
            TextField(Constants.inputPhoneText, text: Binding(get: {
                phoneTextField
            }, set: { newValue in
                phoneTextField = newValue
            })).onChange(of: phoneTextField) { newValue in
                phoneTextField = viewModel.formatPhone(phone: newValue)
                if phoneTextField.count > 17 {
                    currentTextField = .password
                }
            }
            .keyboardType(.phonePad)
            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
            .padding()
            .focused($currentTextField, equals: .phone)
            .onSubmit {
                currentTextField = .password
            }
            Divider()
                .padding(.horizontal)
                .foregroundStyle(.appLightGray)
            ZStack(alignment: .trailing) {
                Group {
                    if passwordIsShow {
                        TextField(Constants.inputPassText, text: $passwordTextField)
                            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                            .padding()
                            .focused($currentTextField, equals: .password)
                            .onSubmit {
                                currentTextField = nil
                            }.onChange(of: passwordTextField) { newValue in
                                passwordTextField = viewModel.cutString(text: newValue, maxCount: 15)
                            }
                    } else {
                        SecureField(Constants.inputPassText, text: $passwordTextField)
                            .textContentType(.password)
                            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                            .padding()
                            .focused($currentTextField, equals: .password)
                            .onSubmit {
                                currentTextField = nil
                            }
                            .onChange(of: passwordTextField) { newValue in
                                passwordTextField = viewModel.cutString(text: newValue, maxCount: 15)
                            }
                    }
                }.padding(.trailing, 32)
                    .offset(x: shakePasswordField ? 7 : 0)
                    .border(shakePasswordField ? .red : .clear)
                
                Button {
                    passwordIsShow.toggle()
                } label: {
                    Image(systemName: passwordIsShow ? "eye" : "eye.slash")
                        .foregroundStyle(.black)
                }
                .padding()
            }
            Divider()
                .padding(.zero)
                .foregroundStyle(.appLightGray)
        }
    }

    private func getButton() -> some View {
        Button {
            if passwordTextField.count < 6 {
                withAnimation(Animation.default.repeatCount(7).speed(5)) {
                    shakePasswordField = true 
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.linear(duration: 1).delay(0.3)) {
                        self.shakePasswordField = false
                    }
                }
            } else {
                showingSheet.toggle()
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
                    Text(Constants.signUpText)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
        }
        .fullScreenCover(isPresented: $showingSheet, content: DetailView.init)
        .environmentObject(
            viewModel
        )
        .frame(width: 300, height: 55)
        .tint(.white)
        .background(.white)
        .font(.bold(.custom(Constants.fontVerdana, size: 20))())
        .cornerRadius(30)
        .padding()
        .alert(isPresented: $passwordIsShortAlert) {
            Alert(title: Text("Ошибка"), message: Text(Constants.passwordIsShortText))
        }
    }
}
