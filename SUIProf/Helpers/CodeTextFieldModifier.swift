//
//  CodeTextFieldModifier.swift
//  SUIProf
//
//  Created by Sonata Girl on 07.05.2024.
//

import SwiftUI
/// Текстфилд для ввода кода верификации
struct CodeTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Verdana", size: 40))
            .padding(.vertical)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .foregroundStyle(.appGray)
            .frame(width: 60, height: 70)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func codesTextField() -> some View {
        modifier(CodeTextFieldModifier())
    }
}
