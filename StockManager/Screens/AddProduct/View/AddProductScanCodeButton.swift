//
//  AddProductScanCodeButton.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 30/6/2565 BE.
//

import UIKit
import RxCocoa
import RxSwift

final class AddProductScanCodeButton: UIView {

    let onTap = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private let colorTheme = UIColor(hexString: "#4165ED")

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 10
        return stackview
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "barcode_scan")
        imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = colorTheme
        label.font = .boldSukhumvitTadmai(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
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
        heightAnchor.constraint(equalToConstant: 38).isActive = true
        clipsToBounds = true
        layer.cornerRadius = 19
        layer.borderColor = colorTheme.cgColor
        layer.borderWidth = 1
        addSubview(stackview)

        stackview.addArrangedSubview(iconView)
        stackview.addArrangedSubview(titleLabel)
        stackview.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.center.equalToSuperview()
        }

        let tap = UITapGestureRecognizer()
        tap.rx.event.map { _ in return () }.bind(to: onTap).disposed(by: disposeBag)
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }

    func configure(title: String) {
        titleLabel.text = title
    }

}
