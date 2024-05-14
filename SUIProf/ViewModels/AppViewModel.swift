//
//  AppViewModel.swift
//  SUIProf
//
//  Created by Sonata Girl on 07.05.2024.
//

import Foundation

final class AppViewModel: ObservableObject {

    @Published var goods: [Good] = []
    @Published var currentIndexGood: Int?
    @Published var sourceTypes: [String] = [
        "filterBed",
        "filterSofa",
        "filterChair"
    ]
    @Published var dates: [String] = []

    init() {
        fillGoods()
        fillDates()
    }

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

    func increaseCountToGood(index: Int) {
        goods[index].count += 1
    }

    func decreaseCountToGood(index: Int) {
        goods[index].count -= 1
    }

    func getCurrentGood() -> Good {
        guard let index = currentIndexGood else {
            return Good(imageName: "", goodName: "", price: 0, oldPrice: 0, count: 0)
        }
        return goods[index]
    }

    private func fillGoods() {
        goods =
        [Good(imageName: "firstGood", goodName: "Sofa", price: 999, oldPrice: 2000, count: 0),
         Good(imageName: "secondGood", goodName: "Armchair", price: 99, oldPrice: 200, count: 0),
         Good(imageName: "thirdGood", goodName: "Bed", price: 1000, oldPrice: 2000, count: 0),
         Good(imageName: "fourGood", goodName: "Chair", price: 99, oldPrice: 200, count: 0),
         Good(imageName: "fiveGood", goodName: "Wardrobe", price: 899, oldPrice: 1100, count: 0),
         Good(imageName: "sixGood", goodName: "Table", price: 600, oldPrice: 1200, count: 0)
        ]
    }

    private func fillDates() {
        for month in 1...12 {
            dates.append(month > 9 ? "\(month)" : "0\(month)")
        }
    }

    /// Форматирование номера карты
    public func formatNumber(numberCard: String) -> String {
        let numbers = numberCard.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        let mask = "XXXX XXXX XXXX XXXX"

        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
