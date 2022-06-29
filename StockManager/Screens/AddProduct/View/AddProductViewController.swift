//
//  AddProductViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit
import BarcodeScanner

final class AddProductViewController: StackButtonViewController {

    private var viewModel: AddProductViewModel!

    private lazy var contentPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow(position: .bottom(offset: 1))
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var contentStackView: ContentStackView = {
        let stackView = ContentStackView()
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .boldSukhumvitTadmai(ofSize: 14)
        label.textColor = .gray600
        label.textAlignment = .left
        label.numberOfLines = 0
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        return label
    }()

    private lazy var productIdTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.mode = .formTextfield
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        return textField
    }()

    private lazy var productNameTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.mode = .formTextfield
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        return textField
    }()

    private lazy var buyingPriceTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.mode = .formTextfield
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        textField.keyboardType = .numberPad
        return textField
    }()

    private lazy var sellingPriceTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.mode = .formTextfield
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        textField.keyboardType = .numberPad
        return textField
    }()

    private lazy var barcodeTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.mode = .formTextfield
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var scanButton: AddProductScanCodeButton = {
        let button = AddProductScanCodeButton()
        return button
    }()

    private lazy var saveButton: ZortButton = {
        let button = ZortButton()
        button.buttonStyle = .main
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        initValidator()
        localizeItems()
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.mainBgColor
        showBackButton()
        configureLayout(contentInsets: UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17))
        addContent(view: contentPanel)
        contentPanel.addSubview(contentStackView)
        contentStackView.addContent(view: titleLabel, spaceAfter: 13)
        contentStackView.addContent(view: productIdTextField, spaceAfter: 10)
        contentStackView.addContent(view: productNameTextField, spaceAfter: 10)
        contentStackView.addContent(view: buyingPriceTextField, spaceAfter: 10)
        contentStackView.addContent(view: sellingPriceTextField, spaceAfter: 10)
        contentStackView.addContent(view: barcodeTextField, spaceAfter: 10)
        contentStackView.addContent(view: scanButton, spaceAfter: 35)
        addButton(saveButton)

        contentStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-28)
            make.right.equalToSuperview().offset(-15)
        }
    }

    private func initValidator() {
        let validator1 = Observable<Bool>.combineLatest(
            productIdTextField.validateState.share(replay: 1, scope: .whileConnected),
            productNameTextField.validateState.share(replay: 1, scope: .whileConnected)
        ) {
            (productId, productName) -> Bool in
            return (productId == .passed) && (productName == .passed)
        }

        let validator2 = Observable<Bool>.combineLatest(
            buyingPriceTextField.validateState.share(replay: 1, scope: .whileConnected),
            sellingPriceTextField.validateState.share(replay: 1, scope: .whileConnected)
        ) {
            (buyingPrice, sellingPrice) in
            return (buyingPrice == .passed) && (sellingPrice == .passed)
        }

        Observable<Bool>.combineLatest(
            validator1.share(replay: 1, scope: .whileConnected),
            validator2.share(replay: 1, scope: .whileConnected),
            barcodeTextField.validateState.share(replay: 1, scope: .whileConnected)
        ) { (valid1, valid2, barcode) in
            return valid1 && valid2 && (barcode == .passed)
        }.bind(to: saveButton.rx.isEnabled).disposed(by: disposeBag)
    }

    override func localizeItems() {
        self.title = Localization.AddProduct.pageTitle
        titleLabel.text = Localization.AddProduct.productInfoTitle
        productIdTextField.placeholder = Localization.AddProduct.productIdHint
        productNameTextField.placeholder = Localization.AddProduct.productNameHint
        buyingPriceTextField.placeholder = Localization.AddProduct.buyingPriceHint
        sellingPriceTextField.placeholder = Localization.AddProduct.sellingPriceHint
        barcodeTextField.placeholder = Localization.AddProduct.barcodeHint
        scanButton.configure(title: Localization.AddProduct.scanBarcode)
        saveButton.setTitle(Localization.AddProduct.save, for: .normal)
    }

    private func openBarcodeScanner() {
        let viewController = BarcodeScannerViewController()
        viewController.title = Localization.AddProduct.scanBarcode
        let backBtn = UIBarButtonItem(image: UIImage(named: "back_arrow"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onBackPressed))
        backBtn.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = backBtn
        viewController.messageViewController.messages.scanningText = Localization.AddProduct.barcodeScanning
        viewController.messageViewController.messages.processingText = Localization.AddProduct.barcodeProcessing
        viewController.messageViewController.messages.unathorizedText = Localization.AddProduct.barcodeUnauthorize
        viewController.messageViewController.messages.notFoundText = Localization.AddProduct.barcodeNotFound
        let title = NSAttributedString(
            string: Localization.AddProduct.barcodeSettings,
            attributes: [.font: UIFont.boldSukhumvitTadmai(ofSize: 17), .foregroundColor : UIColor.white]
        )
        viewController.cameraViewController.settingsButton.setAttributedTitle(title, for: .normal)
        viewController.codeDelegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func configure(with viewModel: AddProductViewModel) {
        self.viewModel = viewModel

        saveButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.viewModel.input.onSave.onNext(())
        }).disposed(by: disposeBag)

        mappingEvent(
            loading: viewModel.output.showLoading,
            andAPIError: viewModel.output.onAPIError
        )

        productIdTextField.rx.text.bind(to: viewModel.input.productId).disposed(by: disposeBag)
        productNameTextField.rx.text.bind(to: viewModel.input.productName).disposed(by: disposeBag)
        buyingPriceTextField.rx.text.bind(to: viewModel.input.buyingPrice).disposed(by: disposeBag)
        sellingPriceTextField.rx.text.bind(to: viewModel.input.sellingPrice).disposed(by: disposeBag)
        barcodeTextField.rx.text.bind(to: viewModel.input.barcode).disposed(by: disposeBag)

        scanButton.onTap.subscribe(onNext: { [weak self] (_) in
            self?.openBarcodeScanner()
        }).disposed(by: disposeBag)
    }

}

extension AddProductViewController: BarcodeScannerCodeDelegate {

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        barcodeTextField.text = code
        barcodeTextField.validateData()
        navigationController?.popViewController(animated: true)
    }

}
