//
//  UIFontExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import UIKit

// MARK: - References
// https://medium.com/@GoalStack/add-font-in-customize-framework-swift-4-2-150a28bd8482
// https://medium.com/@jasonnam/importing-font-files-to-xcode-projects-even-from-framework-9da99ba27c70
extension UIFont {

    public static func customFont(name: String, size: CGFloat) -> UIFont {
        //return UIFont.systemFont(ofSize: size)
        guard let customFont = UIFont(name: name, size: size) else {
            fatalError("""
                Failed to load the \(name) font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }

    enum RegisterFontError: Error {
        case invalidFontFile
        case fontPathNotFound
        case initFontError
        case registerFailed
    }

    static func register(path: String, type: String = "ttf") throws {

        let frameworkBundle = Bundle.main

        guard let resourceBundleURL = frameworkBundle.path(forResource: path, ofType: type) else {
            throw RegisterFontError.fontPathNotFound
        }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),
              let dataProvider = CGDataProvider.init(data: fontData) else {
            throw RegisterFontError.invalidFontFile
        }
        guard let fontRef = CGFont.init(dataProvider) else {
            throw RegisterFontError.initFontError
        }
        var errorRef: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else {
            throw RegisterFontError.registerFailed
        }
    }
}
