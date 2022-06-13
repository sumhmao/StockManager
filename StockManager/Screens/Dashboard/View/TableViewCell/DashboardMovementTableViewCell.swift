//
//  DashboardMovementTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import UIKit
import Kingfisher

final class DashboardMovementTableViewCell: UITableViewCell {

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .top
        stackview.spacing = 7
        return stackview
    }()

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray400
        return imageView
    }()

    private lazy var textStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .fill
        return stackview
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .gray500
        label.numberOfLines = 1
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var movementLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .waitingText
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    private lazy var availableLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
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
        contentView.backgroundColor = .white
        contentView.addSubview(stackview)

        stackview.addArrangedSubview(logoView)
        stackview.addArrangedSubview(textStackview)
        stackview.addArrangedSubview(movementLabel)
        stackview.addArrangedSubview(availableLabel)
        textStackview.addArrangedSubview(idLabel)
        textStackview.addArrangedSubview(titleLabel)

        stackview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(13.44)
            make.bottom.equalToSuperview().offset(-9)
            make.right.equalToSuperview().offset(-14.56)
        }

        logoView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        textStackview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        movementLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        availableLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    func configure(withData data: ReportMovementData.MovementItem, index: Int) {
        logoView.image = nil
        if let imageUrl = data.imageUrl, let url = URL(string: imageUrl) {
            logoView.kf.setImage(with: url)
        }

        idLabel.text = data.id
        titleLabel.text = data.title
        movementLabel.text = data.movement
        availableLabel.text = data.available

        if index % 2 == 0 {
            contentView.backgroundColor = .white
        } else {
            contentView.backgroundColor = .gray100
        }
        if data.lastItem {
            contentView.layer.cornerRadius = 4
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            contentView.layer.cornerRadius = 0
        }

        applyShadow(position: .bottom(offset: 1))
    }

}
