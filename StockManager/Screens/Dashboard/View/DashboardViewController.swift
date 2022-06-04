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

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    private func initUIComponents() {
        title = "DASHBOARD"
        navigationController?.navigationBar.isHidden = false
        showSideMenuButton()
        view.backgroundColor = UIColor.mainBgColor
    }

    override func localizeItems() {

    }

    func configure(with viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

}
