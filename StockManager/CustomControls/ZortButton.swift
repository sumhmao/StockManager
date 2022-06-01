//
//  ZortButton.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 30/5/2565 BE.
//

import UIKit

final class ZortButton: UIButton {

    var buttonStyle: ButtonStyle = .main {
        didSet {
            initUIComponents()
        }
    }

    enum ButtonStyle {
        case main
        case white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        clipsToBounds = true
        layer.cornerRadius = 24.5
        heightAnchor.constraint(equalToConstant: 49).isActive = true
        titleLabel?.font = .boldSukhumvitTadmai(ofSize: 18)

        switch buttonStyle {
        case .main:
            setBackgroundImage(UIImage(color: .zortButtonBG), for: .normal)
            setTitleColor(.white, for: .normal)
            setBackgroundImage(UIImage(color: .lightGray), for: .disabled)
            setTitleColor(.white, for: .disabled)
        case .white:
            setBackgroundImage(UIImage(color: .white), for: .normal)
            setTitleColor(.zortButtonWhiteBGText, for: .normal)
            setBackgroundImage(UIImage(color: .lightGray), for: .disabled)
            setTitleColor(.white, for: .disabled)
        }
    }

}
