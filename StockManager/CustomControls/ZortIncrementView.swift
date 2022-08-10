//
//  ZortIncrementView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 10/8/2565 BE.
//

import UIKit
import RxCocoa
import RxSwift

final class ZortIncrementView: UIView {

    private let disposeBag = DisposeBag()
    let quantity = BehaviorSubject<Int>(value: 0)
    var maxValue: Int?

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 1
        return stackView
    }()

    private lazy var minusBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = .boldSukhumvitTadmai(ofSize: 12)
        button.setTitle("-", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .sukhumvitTadmai(ofSize: 12)
        label.textColor = .black
        return label
    }()

    private lazy var plusBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = .boldSukhumvitTadmai(ofSize: 12)
        button.setTitle("+", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
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
        self.backgroundColor = .gray400
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray400.cgColor
        heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        stackView.addArrangedSubview(minusBtn)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(plusBtn)

        minusBtn.rx.tap.withLatestFrom(quantity).subscribe(onNext: { [weak self] (quantity) in
            self?.quantity.onNext(quantity - 1)
        }).disposed(by: disposeBag)

        plusBtn.rx.tap.withLatestFrom(quantity).subscribe(onNext: { [weak self] (quantity) in
            self?.quantity.onNext(quantity + 1)
        }).disposed(by: disposeBag)

        quantity.subscribe(onNext: { [weak self] (value) in
            self?.minusBtn.isEnabled = value > 0
            if let maxValue = self?.maxValue {
                self?.plusBtn.isEnabled = value < maxValue
            }
            self?.quantityLabel.text = "\(value)"
        }).disposed(by: disposeBag)
    }

}
