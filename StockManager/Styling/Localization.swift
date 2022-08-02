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
        static var cancel: String {
            return "SHARED-CANCEL".localized()
        }
        static var settings: String {
            return "SHARED-SETTINGS".localized()
        }
        static var choosePhotoSource: String {
            return "SHARED-CHOOSE_PHOTO_SOURCE".localized()
        }
        static var cameraSource: String {
            return "SHARED-CAMERA_SOURCE".localized()
        }
        static var cameraSourcePermission: String {
            return "SHARED-CAMERA_SOURCE_PERMISSION".localized()
        }
        static var cameraRollSource: String {
            return "SHARED-CAMERA_ROLL_SOURCE".localized()
        }
        static var cameraRollSourcePermission: String {
            return "SHARED-CAMERA_ROLL_SOURCE_PERMISSION".localized()
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

    enum Products {
        static var pageTitle: String {
            return "PRODUCTS-PAGE_TITLE".localized()
        }
        static var searchHint: String {
            return "PRODUCTS-SEARCH_HINT".localized()
        }
        static var productHeaderTitle: String {
            return "PRODUCTS-PRODUCT_HEADER_TITLE".localized()
        }
        static var stockHeaderTitle: String {
            return "PRODUCTS-STOCK_HEADER_TITLE".localized()
        }
        static var availableHeaderTitle: String {
            return "PRODUCTS-AVAILABLE_HEADER_TITLE".localized()
        }
        static var emptyTitle: String {
            return "PRODUCTS-EMPTY_TITLE".localized()
        }
        static var emptyDescription: String {
            return "PRODUCTS-EMPTY_DESCRIPTION".localized()
        }
    }

    enum AddProduct {
        static var pageTitle: String {
            return "ADD_PRODUCT-PAGE_TITLE".localized()
        }
        static var productInfoTitle: String {
            return "ADD_PRODUCT-PRODUCT_INFO_TITLE".localized()
        }
        static var productIdHint: String {
            return "ADD_PRODUCT-PRODUCT_ID_HINT".localized()
        }
        static var productNameHint: String {
            return "ADD_PRODUCT-PRODUCT_NAME_HINT".localized()
        }
        static var buyingPriceHint: String {
            return "ADD_PRODUCT-BUYING_PRICE_HINT".localized()
        }
        static var sellingPriceHint: String {
            return "ADD_PRODUCT-SELLING_PRICE_HINT".localized()
        }
        static var barcodeHint: String {
            return "ADD_PRODUCT-BARCODE_HINT".localized()
        }
        static var scanBarcode: String {
            return "ADD_PRODUCT-SCAN_BARCODE".localized()
        }
        static var barcodeScanning: String {
            return "ADD_PRODUCT-BARCODE_SCANNING".localized()
        }
        static var barcodeProcessing: String {
            return "ADD_PRODUCT-BARCODE_PROCESSING".localized()
        }
        static var barcodeUnauthorize: String {
            return "ADD_PRODUCT-BARCODE_UNAUTHORIZE".localized()
        }
        static var barcodeNotFound: String {
            return "ADD_PRODUCT-BARCODE_NOT_FOUND".localized()
        }
        static var barcodeSettings: String {
            return "ADD_PRODUCT-BARCODE_SETTINGS".localized()
        }
        static var addNewPhotoLabel: String {
            return "ADD_PRODUCT-ADD_NEW_PHOTO_LABEL".localized()
        }
        static var deletePhotoLabel: String {
            return "ADD_PRODUCT-DELETE_PHOTO_LABEL".localized()
        }
        static var save: String {
            return "ADD_PRODUCT-SAVE".localized()
        }
    }

    enum ReportList {
        static var pageTitle: String {
            return "REPORT_LIST-PAGE_TITLE".localized()
        }
        static var documentListHeader: String {
            return "REPORT_LIST-DOCUMENT_LIST_HEADER".localized()
        }
        static var openLink: String {
            return "REPORT_LIST-OPEN_LINK".localized()
        }
        static var shareLink: String {
            return "REPORT_LIST-SHARE_LINK".localized()
        }
        static var copyLink: String {
            return "REPORT_LIST-COPY_LINK".localized()
        }
    }

}
