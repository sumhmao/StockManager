//
//  Localization.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import Foundation

enum Localization {

    enum Shared {
        static var loading: String {
            return "SHARED-LOADING".localized()
        }
    }

    enum Main {
        static var emailHint: String {
            return "MAIN-EMAIL_HINT".localized()
        }
        static var passwordHint: String {
            return "MAIN-PASSWORD_HINT".localized()
        }
        static var loginButton: String {
            return "MAIN-LOGIN_BUTTON".localized()
        }
    }

}
