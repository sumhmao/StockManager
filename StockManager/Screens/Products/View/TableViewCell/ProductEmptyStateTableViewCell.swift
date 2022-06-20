//
//  ProductEmptyStateTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 20/6/2565 BE.
//

import UIKit

final class ProductEmptyStateTableViewCell: UITableViewCell {

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .fill
        return stackview
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "product_empty_icon")
        imageView.heightAnchor.constraint(equalToConstant: 54.93).isActive = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .blueText
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return label
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
        applyShadow(position: .bottom(offset: 1))
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.addSubview(stackview)
        stackview.addArrangedSubview(iconView)
        stackview.setCustomSpacing(18.07, after: iconView)
        stackview.addArrangedSubview(titleLabel)
        stackview.setCustomSpacing(2, after: titleLabel)
        stackview.addArrangedSubview(descriptionLabel)

        stackview.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }

    func configure() {
        titleLabel.text = Localization.Products.emptyTitle
        descriptionLabel.text = Localization.Products.emptyDescription
    }

}

