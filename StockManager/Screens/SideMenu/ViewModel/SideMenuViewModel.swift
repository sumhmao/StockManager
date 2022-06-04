//
//  SideMenuViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/6/2565 BE.
//

import Foundation
import RxSwift

enum SideMenuSection: Int, CaseIterable {
    case shopName = 0
    case menu = 1
}

protocol SideMenuDataSource {
    func numberOfSections() -> Int
    func sectionAt(index: Int) -> SideMenuSection?
    func numberOfRowIn(section: SideMenuSection) -> Int
    func shopName() -> String?
    func menuItemDataAt(index: Int) -> MenuItemDisplayModel?
}

final class SideMenuViewModel: ViewModelType {

    struct Input {
        let didTapMenu: AnyObserver<Int>
        let didTapLogout: AnyObserver<Void>
    }
    struct Output {
        let dataUpdate: Observable<Void>
        let menuTap: Observable<SideMenuItem>
    }

    let input: Input
    let output: Output
    var datasource: SideMenuDataSource { return self }

    private let didTapMenu = PublishSubject<Int>()
    private let didTapLogout = PublishSubject<Void>()
    private let dataUpdate = PublishSubject<Void>()
    private let menuTap = PublishSubject<SideMenuItem>()
    private let disposeBag = DisposeBag()
    private let allMenu: [SideMenuItem]

    init() {
        self.input = Input(
            didTapMenu: didTapMenu.asObserver(),
            didTapLogout: didTapLogout.asObserver()
        )
        self.output = Output(
            dataUpdate: dataUpdate.asObservable(),
            menuTap: menuTap.asObservable()
        )

        var allAccessibleMenu = [SideMenuItem]()
        for menu in SideMenuItem.allCases {
            // check for permission here
            allAccessibleMenu.append(menu)
        }
        allMenu = allAccessibleMenu

        didTapMenu.subscribe(onNext: { [weak self] (index) in
            guard let self = self, index >= 0, index < self.allMenu.count else { return }
            let selectedMenu = self.allMenu[index]
            self.menuTap.onNext(selectedMenu)
        }).disposed(by: disposeBag)

        didTapLogout.subscribe(onNext: { (_) in
            UserContext.shared.logout()
        }).disposed(by: disposeBag)
    }

}

extension SideMenuViewModel: SideMenuDataSource {

    func numberOfSections() -> Int {
        return SideMenuSection.allCases.count
    }

    func sectionAt(index: Int) -> SideMenuSection? {
        return SideMenuSection(rawValue: index)
    }

    func numberOfRowIn(section: SideMenuSection) -> Int {
        switch section {
        case .shopName:
            return 1
        case .menu:
            return allMenu.count
        }
    }

    func shopName() -> String? {
        return UserContext.shared.merchant?.displayName
    }

    func menuItemDataAt(index: Int) -> MenuItemDisplayModel? {
        guard index >= 0, index < allMenu.count else { return nil }
        return allMenu[index].menuData
    }

}

fileprivate extension SideMenuItem {

    var icon: UIImage? {
        switch self {
        case .report:
            return UIImage(named: "report_menu_logo")
        case .sellList:
            return UIImage(named: "sell_list_menu_logo")
        case .buyList:
            return UIImage(named: "buy_list_menu_logo")
        case .products:
            return UIImage(named: "products_menu_logo")
        case .branchAndWarehouse:
            return UIImage(named: "warehouse_menu_logo")
        case .settings:
            return UIImage(named: "settings_menu_logo")
        }
    }

    var iconSize: CGSize {
        switch self {
        case .report:
            return CGSize(width: 12, height: 12)
        case .sellList:
            return CGSize(width: 12, height: 10.67)
        case .buyList:
            return CGSize(width: 14.63, height: 13)
        case .products:
            return CGSize(width: 11.38, height: 13)
        case .branchAndWarehouse:
            return CGSize(width: 14, height: 11.2)
        case .settings:
            return CGSize(width: 14, height: 14)
        }
    }

    var title: String? {
        switch self {
        case .report:
            return Localization.SideMenuTitle.report
        case .sellList:
            return Localization.SideMenuTitle.sellList
        case .buyList:
            return Localization.SideMenuTitle.buyList
        case .products:
            return Localization.SideMenuTitle.products
        case .branchAndWarehouse:
            return Localization.SideMenuTitle.branchAndWarehouse
        case .settings:
            return Localization.SideMenuTitle.settings
        }
    }

    var menuData: MenuItemDisplayModel {
        return MenuItemDisplayModel(icon: icon, iconSize: iconSize, title: title)
    }

}
