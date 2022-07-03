//
//  AddProductSelectPhotoView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/7/2565 BE.
//

import UIKit
import RxCocoa
import RxSwift

final class AddProductSelectPhotoView: UIView {

    let addImageTap = PublishSubject<Void>()
    let deleteImageTap = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private var borderLayer: CALayer?

    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .clear
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()

    private lazy var addImageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .gray500
        label.font = .boldSukhumvitTadmai(ofSize: 14)
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 97).isActive = true
        return label
    }()

    private lazy var imageView: ZortAdjustHeightImageView = {
        let imageView = ZortAdjustHeightImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        return imageView
    }()

    private lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .blueText
        label.font = .boldSukhumvitTadmai(ofSize: 14)
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.isHidden = true
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

    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer?.removeFromSuperlayer()
        borderLayer = addLineDashedStroke(pattern: [15, 15], radius: 10, color: UIColor.gray400.cgColor)
    }

    private func initUIComponents() {
        backgroundColor = .clear
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        stackView.addArrangedSubview(addImageLabel)
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(10.87, after: imageView)
        stackView.addArrangedSubview(deleteLabel)

        let addImageTap = UITapGestureRecognizer()
        addImageTap.rx.event.map { _ in return () }.bind(to: self.addImageTap).disposed(by: disposeBag)
        addImageLabel.isUserInteractionEnabled = true
        addImageLabel.addGestureRecognizer(addImageTap)

        let deleteImageTap = UITapGestureRecognizer()
        deleteImageTap.rx.event.map { _ in return () }.bind(to: self.deleteImageTap).disposed(by: disposeBag)
        deleteLabel.isUserInteractionEnabled = true
        deleteLabel.addGestureRecognizer(deleteImageTap)
    }

    func configure(image: UIImage?) {
        addImageLabel.text = Localization.AddProduct.addNewPhotoLabel
        deleteLabel.attributedText = Localization.AddProduct.deletePhotoLabel.underlineText
        imageView.image = image

        guard image != nil else {
            stackView.snp.removeConstraints()
            stackView.snp.makeConstraints { make in
                make.top.left.bottom.right.equalToSuperview()
            }
            addImageLabel.isHidden = false
            imageView.isHidden = true
            deleteLabel.isHidden = true
            return
        }

        stackView.snp.removeConstraints()
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-23)
        }
        addImageLabel.isHidden = true
        imageView.isHidden = false
        deleteLabel.isHidden = false
    }
    
}
