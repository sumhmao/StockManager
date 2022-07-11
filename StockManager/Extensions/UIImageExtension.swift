//
//  UIImageExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 30/5/2565 BE.
//

import UIKit

extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    var base64String: String? {
        let imageData = self.jpegData(compressionQuality: 1)
        return imageData?.base64EncodedString()
    }

    func resizeWithMaxSize(maxSize: CGFloat = 500) -> UIImage? {
        guard max(size.width, size.height) > maxSize else { return self }

        let widthRatio  = maxSize / size.width
        let heightRatio = maxSize / size.height

        var newSize: CGSize
        if size.width < size.height {
            newSize = CGSize(width: size.width * heightRatio,
                             height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,
                             height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
