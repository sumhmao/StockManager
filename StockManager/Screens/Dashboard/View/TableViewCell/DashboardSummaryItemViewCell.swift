//
//  DashboardSummaryItemViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import UIKit

final class DashboardSummaryItemViewCell: UITableViewCell {

    private lazy var panelView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.applyShadow(position: .bottom(offset: 1))
        return view
    }()

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .clear
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .fill
        stackview.spacing = 10
        return stackview
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .boldSukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
        contentView.addSubview(panelView)
        panelView.addSubview(stackview)
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(valueLabel)

        panelView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        stackview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-9)
            make.right.equalToSuperview().offset(-12)
        }
    }

    func configure(withTitle title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }

}
