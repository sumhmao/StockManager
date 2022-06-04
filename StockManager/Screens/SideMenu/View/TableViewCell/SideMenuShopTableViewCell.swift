//
//  SideMenuShopTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 4/6/2565 BE.
//

import UIKit

final class SideMenuShopTableViewCell: UITableViewCell {

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "zort_menu_logo")
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .boldSukhumvitTadmai(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
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
        contentView.backgroundColor = .zortBranding
        contentView.addSubview(logoView)
        contentView.addSubview(nameLabel)

        logoView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(33.16)
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(26)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
            make.top.equalTo(logoView.snp.bottom).offset(64.84).priority(.medium)
            make.top.greaterThanOrEqualTo(logoView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(26)
            make.bottom.equalToSuperview().offset(-17)
            make.right.equalToSuperview().offset(-26)
        }
    }

    func configure(withName name: String?) {
        nameLabel.text = name
    }

}
