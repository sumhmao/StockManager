//
//  MainCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation
import RxSwift

final class MainCoordinator: BaseCoordinator {

    let navigateToDashboard = PublishSubject<Void>()
    private var mainViewController: MainViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = MainViewModel()
        viewModel.output.loginSucceed.bind(to: navigateToDashboard).disposed(by: disposeBag)
        mainViewController = MainViewController()
        mainViewController.configure(with: viewModel)
        navigationController.setViewControllers([mainViewController], animated: true)
    }

}
