//
//  DashboardHeaderTitleView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 14/6/2565 BE.
//

import UIKit

final class DashboardHeaderTitleView: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        return stackView
    }()

    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        backgroundColor = .clear
        addSubview(stackView)
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(headerTitle)

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(11)
            make.bottom.equalToSuperview().offset(-7)
            make.right.equalToSuperview().offset(-12)
        }
    }

    func configure(title: String, filter: String) {
        headerTitle.text = title
    }

}
