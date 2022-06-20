//
//  ProductTableHeaderView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 21/6/2565 BE.
//

import UIKit

final class ProductTableHeaderView: UITableViewHeaderFooterView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        return stackView
    }()

    private lazy var productHeaderTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = Localization.Products.productHeaderTitle
        return label
    }()

    private lazy var stockHeaderTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .right
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = Localization.Products.stockHeaderTitle
        return label
    }()

    private lazy var availableHeaderTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = Localization.Products.availableHeaderTitle
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initUIComponent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponent()
    }

    private func initUIComponent() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        applyShadow(position: .bottom(offset: 1))

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(productHeaderTitle)
        stackView.addArrangedSubview(stockHeaderTitle)
        stackView.setCustomSpacing(20, after: stockHeaderTitle)
        stackView.addArrangedSubview(availableHeaderTitle)

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(13.44)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-14.56)
            make.height.equalTo(20)
        }
    }

}
