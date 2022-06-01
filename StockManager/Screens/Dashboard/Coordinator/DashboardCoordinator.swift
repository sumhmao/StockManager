//
//  DashboardCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import RxSwift

final class DashboardCoordinator: BaseCoordinator {

    private var dashboardViewController: DashboardViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = DashboardViewModel()
        dashboardViewController = DashboardViewController()
        dashboardViewController.configure(with: viewModel)
        navigationController.setViewControllers([dashboardViewController], animated: true)
    }

}
