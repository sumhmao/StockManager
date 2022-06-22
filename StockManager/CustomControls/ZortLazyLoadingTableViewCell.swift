//
//  ZortLazyLoadingTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 22/6/2565 BE.
//

import UIKit

final class ZortLazyLoadingTableViewCell: UITableViewCell {

    private var heightConstraint: NSLayoutConstraint?
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        heightConstraint?.isActive = true

        contentView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func configure(color: UIColor, height: CGFloat = 50) {
        contentView.backgroundColor = color
        heightConstraint?.constant = height
    }

}
