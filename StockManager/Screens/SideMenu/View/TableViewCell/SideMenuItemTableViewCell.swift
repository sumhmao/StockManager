//
//  SideMenuItemTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 4/6/2565 BE.
//

import UIKit

final class SideMenuItemTableViewCell: UITableViewCell {

    private lazy var logoPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .menuIconBGColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuSeparatorColor
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

        contentView.addSubview(logoPanel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        logoPanel.addSubview(logoView)

        logoPanel.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(12)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(21)
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(logoPanel.snp.right).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            make.right.equalToSuperview().offset(12)
        }
        logoView.snp.makeConstraints { make in
            make.width.height.equalTo(0)
            make.center.equalToSuperview()
        }
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.bottom.right.equalToSuperview()
        }
    }

    func configure(withData data: MenuItemDisplayModel) {
        logoView.image = data.icon
        logoView.snp.updateConstraints { make in
            make.width.equalTo(data.iconSize.width)
            make.height.equalTo(data.iconSize.height)
        }
        titleLabel.text = data.title
    }

}
