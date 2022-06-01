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
    private var dashboardCoordinator: DashboardCoordinator?

    override func start() {
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: UserContext.logoutNotificationKey))
            .subscribe(onNext: { [weak self] (_) in
                self?.navigateToMain()
            }).disposed(by: disposeBag)

        if UserContext.shared.loggedIn {
            navigateToDashboard()
        } else {
            navigateToMain()
        }
    }

    private func navigateToMain() {
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.navigateToDashboard.subscribe(onNext: { [weak self] in
            self?.navigateToDashboard()
        }).disposed(by: disposeBag)
        mainCoordinator?.start()
    }

    private func navigateToDashboard() {
        dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator?.start()
    }
    
}
