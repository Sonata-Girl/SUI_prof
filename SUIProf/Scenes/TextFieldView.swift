//
//  TextFieldView.swift
//  SUIProf
//
//  Created by Sonata Girl on 10.05.2024.
//

import SwiftUI
/// ТекстФилд
struct TextFieldView: View {

    var placeholder: String
    @Binding var text: String

    enum Constants {
        static let verdanaFont = "Verdana"
    }

    var body: some View {
        TextField(placeholder, text: $text)
            .textContentType(.password)
            .font(.custom(Constants.verdanaFont, size: 20))
            .foregroundStyle(.appGray)
            .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 0 ))
            .onChange(of: text) { newValue in
                text = newValue
            }
    }
}




