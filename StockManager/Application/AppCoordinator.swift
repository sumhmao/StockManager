//
//  AppCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation
import RxSwift

final class AppCoordinator: BaseCoordinator {

    static let sideMenuNotificationKey = "SideMenuNotificationKey"

    private let disposeBag = DisposeBag()
    private var mainCoordinator: MainCoordinator?
    private var sideMenuCoordinator: SideMenuCoordinator?
    private var dashboardCoordinator: DashboardCoordinator?

    private var currentMenu: SideMenuItem?

    override func start() {
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: UserContext.logoutNotificationKey))
            .subscribe(onNext: { [weak self] (_) in
                self?.navigateToMain(animated: false)
            }).disposed(by: disposeBag)

        NotificationCenter.default.rx.notification(Notification.Name(rawValue: AppCoordinator.sideMenuNotificationKey))
            .subscribe(onNext: { [weak self] (_) in
                self?.showSideMenu()
            }).disposed(by: disposeBag)

        if UserContext.shared.loggedIn {
            navigateToDashboard()
        } else {
            navigateToMain()
        }
    }

    private func navigateToMain(animated: Bool = true) {
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.animatedTransition = animated
        mainCoordinator?.loginComplete.subscribe(onNext: { [weak self] in
            self?.navigateToDashboard()
        }).disposed(by: disposeBag)
        mainCoordinator?.start()
    }

    private func showSideMenu() {
        sideMenuCoordinator = SideMenuCoordinator(navigationController: navigationController)
        sideMenuCoordinator?.itemTap.subscribe(onNext: { [weak self] (item) in
            self?.currentMenu = item
            switch item {
            case .report:
                self?.navigateToDashboard()
            case .sellList:
                self?.navigateToSellList()
            case .buyList:
                self?.navigateToBuyList()
            case .products:
                self?.navigateToProducts()
            case .branchAndWarehouse:
                self?.navigateToBranchAndWarehouse()
            case .settings:
                self?.navigateToSettings()
            }
        }).disposed(by: disposeBag)
        sideMenuCoordinator?.start()
    }

    private func navigateToDashboard() {
        dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator?.start()
    }

    private func navigateToReport() {

    }

    private func navigateToSellList() {

    }

    private func navigateToBuyList() {

    }

    private func navigateToProducts() {

    }

    private func navigateToBranchAndWarehouse() {

    }

    private func navigateToSettings() {

    }
    
}
