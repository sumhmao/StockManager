//
//  StringExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation

extension String {

    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func localized() -> String {
        return LanguageManager.sharedInstance.get(self)
    }

}
