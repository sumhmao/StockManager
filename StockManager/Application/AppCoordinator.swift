//
//  AppCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation
import RxSwift

final class AppCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()
    private var mainCoordinator: MainCoordinator?

    override func start() {
        navigateToMain()
    }

    private func navigateToMain() {
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
    }
    
}
