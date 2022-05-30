//
//  UIViewExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import UIKit
import SnapKit

extension UIView {

    var safeAreaTop: ConstraintItem {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.snp.topMargin
        } else {
            return self.snp.top
        }
    }

    var safeAreaBottom: ConstraintItem {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.snp.bottomMargin
        } else {
            return self.snp.bottom
        }
    }

}
