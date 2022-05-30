//
//  MainCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation
import RxSwift

final class MainCoordinator: BaseCoordinator {

    private var mainViewController: MainViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = MainViewModel()
        mainViewController = MainViewController()
        mainViewController.configure(with: viewModel)
        navigationController.setViewControllers([mainViewController], animated: true)
    }

}
