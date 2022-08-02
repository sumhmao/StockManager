//
//  ReportListCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import Foundation
import RxSwift

final class ReportListCoordinator: BaseCoordinator {

    private var reportListViewController: ReportListViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = ReportListViewModel()
        reportListViewController = ReportListViewController()
        reportListViewController.configure(with: viewModel)
        navigationController.setViewControllers([reportListViewController], animated: false)
    }

}
