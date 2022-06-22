//
//  AddProductViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class AddProductViewController: StackButtonViewController {

    private var viewModel: AddProductViewModel!

    private lazy var saveButton: ZortButton = {
        let button = ZortButton()
        button.buttonStyle = .main
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.mainBgColor
        showBackButton()
        configureLayout(contentInsets: UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17))
        addButton(saveButton)
    }

    override func localizeItems() {
        self.title = Localization.AddProduct.pageTitle
        saveButton.setTitle(Localization.AddProduct.save, for: .normal)
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
    }

}
