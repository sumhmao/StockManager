//
//  UIScrollViewExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 30/5/2565 BE.
//

import UIKit

extension UIScrollView {

    func createScrollViewSnapshot(padding: UIEdgeInsets = .zero) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0.0)
        let savedContentOffset = self.contentOffset
        let savedFrame = self.frame
        self.contentOffset = CGPoint.zero
        self.frame = CGRect(x: padding.left,
                            y: padding.top,
                            width: contentSize.width - (padding.left + padding.right),
                            height: contentSize.height - (padding.top + padding.bottom))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.contentOffset = savedContentOffset
        self.frame = savedFrame
        UIGraphicsEndImageContext()
        return image
    }

}
