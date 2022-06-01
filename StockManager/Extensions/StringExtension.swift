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

}
