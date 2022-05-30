//
//  AppFont.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import UIKit

struct SukhumvitTadmai {
    static let thin = "SukhumvitTadmai-Thin"
    static let regular = "SukhumvitTadmai-Text"
    static let bold = "SukhumvitTadmai-Bold"
    static let heavy = "SukhumvitTadmai-Heavy"
}

struct AppFont {

    // Only call load font once
    static let registerFonts: () = {
        [
            SukhumvitTadmai.thin,
            SukhumvitTadmai.regular,
            SukhumvitTadmai.bold,
            SukhumvitTadmai.heavy
        ].forEach { (name) in
            try? UIFont.register(path: name)
        }
    }()

    static func showAllFonts() {
        UIFont.familyNames.forEach { (familyName) in
            UIFont.fontNames(forFamilyName: familyName).forEach({
                print("Family Name: \(familyName), Font Name: \($0)")
            })
        }
    }
}

extension UIFont {

    class func thinSukhumvitTadmai(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.customFont(name: SukhumvitTadmai.thin, size: fontSize)
    }

    class func sukhumvitTadmai(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.customFont(name: SukhumvitTadmai.regular, size: fontSize)
    }

    class func boldSukhumvitTadmai(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.customFont(name: SukhumvitTadmai.bold, size: fontSize)
    }

    class func heavySukhumvitTadmai(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.customFont(name: SukhumvitTadmai.heavy, size: fontSize)
    }
    
}
