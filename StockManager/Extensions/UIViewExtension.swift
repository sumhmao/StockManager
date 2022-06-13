//
//  UIViewExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import UIKit

enum ShadowPosition {
    case top(offset: CGFloat)
    case center
    case bottom(offset: CGFloat)
}

extension UIView {

    func applyShadow(position: ShadowPosition = .center,
                     color: UIColor = UIColor.gray500,
                     opacity: Float = 0.5,
                     radius: CGFloat = 3) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius

        switch position {
        case .top(let offset):
            self.layer.shadowOffset = CGSize(width: 0, height: -(radius + offset))
        case .center:
            self.layer.shadowOffset = .zero
        case .bottom(let offset):
            self.layer.shadowOffset = CGSize(width: 0, height: radius + offset)
        }
    }

}
