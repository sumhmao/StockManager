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

    enum SideMenuTitle {
        static var report: String {
            return "SIDE_MENU-REPORT".localized()
        }
        static var sellList: String {
            return "SIDE_MENU-SELL_LIST".localized()
        }
        static var buyList: String {
            return "SIDE_MENU-BUY_LIST".localized()
        }
        static var products: String {
            return "SIDE_MENU-PRODUCTS".localized()
        }
        static var branchAndWarehouse: String {
            return "SIDE_MENU-WAREHOUSE".localized()
        }
        static var settings: String {
            return "SIDE_MENU-SETTINGS".localized()
        }
        static var logout: String {
            return "SIDE_MENU-LOGOUT".localized()
        }
    }

    enum Dashboard {
        static var pageTitle: String {
            return "DASHBOARD-PAGE_TITLE".localized()
        }
        static var productHeaderTitle: String {
            return "DASHBOARD-PRODUCT_HEADER_TITLE".localized()
        }
        static var movementHeaderTitle: String {
            return "DASHBOARD-MOVEMENT_HEADER_TITLE".localized()
        }
        static var availableHeaderTitle: String {
            return "DASHBOARD-AVAILABLE_HEADER_TITLE".localized()
        }
    }

}
