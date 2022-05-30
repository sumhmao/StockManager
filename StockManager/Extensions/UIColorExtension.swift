//
//  UIColorExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import UIKit

extension UIColor {

    ///  Creates an UIColor object from HEX string.
    ///
    ///  - Parameters:
    ///     - hexString: HEX string in "#363636" format.
    convenience init(hexString: String) {

        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
