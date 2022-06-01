//
//  DashboardViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class DashboardViewController: BaseViewController {

    private var viewModel: DashboardViewModel!

    private lazy var logoutButton: ZortButton = {
        let button = ZortButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    private func initUIComponents() {
        title = "DASHBOARD"
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.mainBgColor
        view.addSubview(logoutButton)

        logoutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }

    override func localizeItems() {
        logoutButton.setTitle("LOGOUT", for: .normal)
    }

    func configure(with viewModel: DashboardViewModel) {
        self.viewModel = viewModel

        logoutButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.viewModel.input.logoutTap.onNext(())
        }).disposed(by: disposeBag)
    }

}
