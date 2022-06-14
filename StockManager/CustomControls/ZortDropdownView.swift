//
//  ZortDropdownView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import UIKit

final class ZortDropdownView: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .black
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 11.43).isActive = true
        imageView.image = UIImage(named: "arrow_dropdown")
        return imageView
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
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray400.cgColor
        widthAnchor.constraint(equalToConstant: 119).isActive = true
        heightAnchor.constraint(equalToConstant: 24).isActive = true

        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(arrowImageView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-6.57)
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }

}
