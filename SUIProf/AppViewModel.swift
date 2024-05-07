//
//  AppViewModel.swift
//  SUIProf
//
//  Created by Sonata Girl on 07.05.2024.
//

import SwiftUI

final class AppViewModel: ObservableObject {
    @Published var selectedPurchases: [Int] = []

    func formatPhone(phone: String) -> String {
        let number = phone.replacingOccurrences(of: "[^0-91]",
                                                with: "",
                                                options: .regularExpression)
        let mask = "+# (###) ###-##-##"
        var result = ""
        var index = number.startIndex
        for char in mask where index < number.endIndex {
            if char == "#" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }

    func cutString(text: String, maxCount: Int) -> String {
        var someString = text
        if text.count > 15 {
            let rangeSomeString = text.index(text.endIndex, offsetBy: -1) ..<
            someString.index(someString.endIndex, offsetBy: 0)
            someString.removeSubrange(rangeSomeString)
            return someString
        }
        return text
    }
}
