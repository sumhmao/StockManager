//
//  LanguageManager.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import Foundation
import Locksmith

enum SupportedLanguages: String {
    case thai = "th"
    case english = "en"

    var locale: Locale {
        switch self {
        case .thai:
            return Locale(identifier: "th_TH")
        case .english:
            return Locale(identifier: "en_US")
        }
    }
}

final class LanguageManager {

    static let sharedInstance = LanguageManager()

    let account = "UserLanguageAccount"
    let languageKey = "UserLanguageKey"

    private(set) var bundle: Bundle?
    private(set) var currentLanguage = SupportedLanguages.thai.rawValue
    private var languageSet = false

    var userAlreadySetLanguage: Bool {
        return languageSet
    }

    private init() {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: account)
        if let dictionary = dictionary, let language = dictionary[languageKey] as? String {
            currentLanguage = language
            languageSet = true
        }
        setLanguage(currentLanguage, save: languageSet)
    }

    func getCurrentLanguage() -> SupportedLanguages {
        return SupportedLanguages(rawValue: currentLanguage) ?? .thai
    }

    func setLanguage(_ language: SupportedLanguages, save: Bool = true) {
        setLanguage(language.rawValue, save: save)
    }

    private func setLanguage(_ countryCode: String, save: Bool) {
        currentLanguage = countryCode
        let path = Bundle.main.path(forResource: countryCode, ofType: "lproj")
        if let bundlePath = path {
            bundle = Bundle(path: bundlePath)
        }
        if save {
            do {
                try Locksmith.updateData(data: [languageKey: countryCode], forUserAccount: account)
                languageSet = true
            } catch {}
        }

        NotificationCenter.default.post(name: Notification.Name.kLanguageChange, object: nil)
    }

    func get(_ key: String) -> String {
        if let languageBundle = bundle {
            return languageBundle.localizedString(forKey: key, value: nil, table: nil)
        } else {
            return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
    }

}
