//
//  StringExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import UIKit

extension String {

    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func htmlToAttributedString(withFont font: UIFont) -> NSAttributedString? {
        let modifiedFont = String(
            format:"<span style=\"font-family: '\(font.familyName)'; font-size: \(font.pointSize)\">%@</span>", self
        )
        return modifiedFont.htmlToAttributedString
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    func localized() -> String {
        return LanguageManager.sharedInstance.get(self)
    }

    var isCurrencyFormat: Bool {
        let currencyRegex = "(?=.*?\\d)^\\$?(([1-9]\\d{0,2}(,\\d{3})*)|\\d+)?(\\.\\d{1,2})?$"
        return NSPredicate(format: "SELF MATCHES %@", currencyRegex).evaluate(with: self)
    }

    var underlineText: NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

}
