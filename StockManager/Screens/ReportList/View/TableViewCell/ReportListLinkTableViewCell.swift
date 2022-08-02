//
//  ReportListLinkTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import UIKit

final class ReportListLinkTableViewCell: UITableViewCell {

    private lazy var backgroundPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow(position: .bottom(offset: 1))
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .gray600
        label.textAlignment = .left
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
        contentView.backgroundColor = .clear
        contentView.addSubview(backgroundPanel)
        backgroundPanel.addSubview(titleLabel)

        backgroundPanel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-7)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(13.48)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-13.48)
            make.height.greaterThanOrEqualTo(16)
        }
    }

    func configure(data: ReportLinkData) {
        titleLabel.text = data.title
    }
}
