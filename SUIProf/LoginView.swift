//
//  LoginView.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import SwiftUI

struct LoginView: View {

    enum Constants {
        static let loginText = "Log in"
        static let fontVerdana = "Verdana"
        static let inputPhoneText = "Введите телефон"
        static let inputPassText = "Введите пароль"
        static let signUpText = "Sign up"
        static let forgotPasswordText = "Forgot your password?"
        static let checkText = "Check Verification"
    }

    @State private var phoneTextField = ""
    @State private var passwordTextField = ""
    @State private var passwordIsShow = false
    @State private var supportPhoneShowOn = false

    var body: some View {
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
                    .foregroundStyle(.black)
            }
            .padding(.top)
            .alert(isPresented: $supportPhoneShowOn) {
                Alert(title: Text("Телефон техподдержки"),message: Text("5-555-555-555"))
            }
            NavigationLink {
                LoginView()
            } label: {
                Text(Constants.checkText)
                    .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                    .foregroundStyle(.black)
                    .padding(.zero)
            }
            .padding(.top)
            Divider()
                .frame(width: 160, height: 1)
                .foregroundStyle(.black)
            Spacer()
        }
        .background(.clear)
    }

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
//                    .stroke(Color.appLightGray)
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
            TextField(Constants.inputPhoneText, text: $phoneTextField.onChange(textFieldWithPhoneFormat))
//            TextField(Constants.inputPhoneText, value: $phoneTextField, formatter: PhoneFormatter())
            .keyboardType(.phonePad)
            .font(.bold(.custom(Constants.fontVerdana, size: 20))())
            .padding()
            Divider()
                .padding(.horizontal)
                .foregroundStyle(.appLightGray)

                ZStack(alignment: .trailing) {
                    Group {
                        if passwordIsShow {
                            TextField(Constants.inputPassText, text: $passwordTextField)
                                .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                                .padding()

                        } else {
                            SecureField(Constants.inputPassText, text: $passwordTextField)
                                .textContentType(.password)
                                .font(.bold(.custom(Constants.fontVerdana, size: 20))())
                                .padding()
                        }
                    }.padding(.trailing, 32)
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
                NavigationLink {
                    DetailView()
                } label: {
                    Text(Constants.signUpText)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                }
            }
        }
        .frame(width: 300, height: 55)
        .tint(.white)
        .background(.white)
        .font(.bold(.custom(Constants.fontVerdana, size: 20))())
        .cornerRadius(30)
        .padding()
    }

    private func textFieldWithPhoneFormat(phoneString: String) {
        self.phoneTextField = formatPhoneNumber(phoneNumber: phoneString, removeLastDigit: phoneString.count == 1)

    }

    func formatPhoneNumber(phoneNumber: String, removeLastDigit: Bool) -> String {
        var numbers: [String] = phoneNumber.replacingOccurrences(of: " ", with: "")
            .filter { !["+", "(", ")", "-", " "].contains($0) }
            .map { String($0) }
        guard !(numbers.count == .zero) else { return "" }
        if removeLastDigit {
            numbers.removeLast()
        }

        numbers.insert("+", at: 0)
        switch numbers.count - 1 {
            case 0:
                numbers += [" (", "   ) ", "   -", "  -  "]
            case 1:
                numbers.insert("(", at: 2)
                numbers += ["   ) ", "   -", "  -  "]
            case 2:
                numbers.insert("(", at: 2)
                numbers += ["  ) ", "   -", "  -  "]
            case 3:
                numbers.insert("(", at: 2)
                numbers += [" ) ", "   -", "  -  "]
            case 4:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers += ["   -", "  -  "]
            case 5:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers += ["  -", "  -  "]
            case 6:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers += [" -", "  -  "]
            case 7:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers.insert("-", at: 10)
                numbers += ["  -  "]
            case 8:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers.insert("-", at: 10)
                numbers += [" -  "]
            case 9:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers.insert("-", at: 10)
                numbers.insert("-", at: 13)
                numbers += [" "]
            case 10:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers.insert("-", at: 10)
                numbers.insert("-", at: 13)
                numbers += [" "]
            case 11:
                numbers.insert("(", at: 2)
                numbers.insert(") ", at: 6)
                numbers.insert("-", at: 10)
                numbers.insert("-", at: 13)
            default: return phoneNumber.map { String($0) }.dropLast().joined(separator: "")
        }
        return numbers.joined(separator: "")
    }
}
