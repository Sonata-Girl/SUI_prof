//
//  PhoneFormatter.swift
//  SUIProf
//
//  Created by Sonata Girl on 06.05.2024.
//

import Foundation

final class PhoneFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        if let string = obj as? String {
            return formattedPhone(phone: string)
        }
        return nil
    }

    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject?
        return true
    }

    func formattedPhone(phone: String?) -> String? {
        guard let number = phone else { return nil }
        let mask = "+ #(###)###-##-##"
        var result = ""
        var index = number.startIndex
        for ch in mask where index < number.endIndex {
            if ch == "#" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
