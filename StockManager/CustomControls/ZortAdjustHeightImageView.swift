//
//  ZortAdjustHeightImageView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 4/7/2565 BE.
//

import UIKit

public final class ZortAdjustHeightImageView: UIImageView {

    private var heightConstraint: NSLayoutConstraint?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        contentMode = .scaleToFill
        heightConstraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        heightConstraint?.isActive = true
    }

    public override var image: UIImage? {
        didSet {
            super.image = image
            guard let imageSize = image?.size else { return }
            heightConstraint?.isActive = false
            if let constraint = heightConstraint {
                removeConstraint(constraint)
            }
            let multiplier =  imageSize.height / imageSize.width
            heightConstraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
            heightConstraint?.isActive = true
        }
    }

}
