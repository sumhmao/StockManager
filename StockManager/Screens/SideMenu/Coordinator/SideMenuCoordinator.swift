//
//  SideMenuCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/6/2565 BE.
//

import Foundation
import RxSwift

enum SideMenuItem: CaseIterable {
    case report
    case sellList
    case buyList
    case products
    case branchAndWarehouse
    case settings
}

final class SideMenuCoordinator: BaseCoordinator {

    let itemTap = PublishSubject<SideMenuItem>()
    private var sideMenuViewController: SideMenuViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        guard let rootView = UIApplication.shared.topMostViewController else { return }
        let viewModel = SideMenuViewModel()
        viewModel.output.menuTap.bind(to: itemTap).disposed(by: disposeBag)
        sideMenuViewController = SideMenuViewController()
        sideMenuViewController.modalTransitionStyle = .crossDissolve
        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        sideMenuViewController.configure(with: viewModel)
        rootView.present(sideMenuViewController!, animated: true)
    }

}
