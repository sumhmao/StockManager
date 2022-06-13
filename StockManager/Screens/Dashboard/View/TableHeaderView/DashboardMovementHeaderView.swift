//
//  DashboardMovementHeaderView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import UIKit

final class DashboardMovementHeaderView: UITableViewHeaderFooterView {

    private lazy var topPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        return stackView
    }()

    private lazy var movementTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var bottomPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()

    private lazy var bottomStackView: UIStackView = {
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
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .left
        label.text = Localization.Dashboard.productHeaderTitle
        return label
    }()

    private lazy var movementHeaderTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = Localization.Dashboard.movementHeaderTitle
        return label
    }()

    private lazy var availableHeaderTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .right
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = Localization.Dashboard.availableHeaderTitle
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

        contentView.addSubview(topPanel)
        contentView.addSubview(bottomPanel)
        topPanel.addSubview(topStackView)
        bottomPanel.addSubview(bottomStackView)

        topPanel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        bottomPanel.snp.makeConstraints { make in
            make.top.equalTo(topPanel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(27)
        }
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(11)
            make.bottom.equalToSuperview().offset(-7)
            make.right.equalToSuperview().offset(-12)
        }
        bottomStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13.44)
            make.right.equalToSuperview().offset(-14)
        }
        initTopSectionViews()
        initBottomSectionViews()
    }

    private func initTopSectionViews() {
        topStackView.addArrangedSubview(movementTitle)
    }

    private func initBottomSectionViews() {
        bottomStackView.addArrangedSubview(productHeaderTitle)
        bottomStackView.addArrangedSubview(movementHeaderTitle)
        bottomStackView.addArrangedSubview(availableHeaderTitle)
    }

    func configure(data: DashboardMovementHeaderDisplayViewModel) {
        movementTitle.text = data.title
    }

}
