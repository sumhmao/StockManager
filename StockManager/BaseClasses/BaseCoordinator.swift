//
//  BaseCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import UIKit

class BaseCoordinator {

    public var navigationController: UINavigationController

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    open func start() {
        fatalError("Implement start in each subclass of Coordinator")
    }

    open func pushTo(viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: true)
    }

    open func changeLastViewController(to toViewController: UIViewController) {
        var vcs = navigationController.viewControllers
        vcs.removeLast()
        vcs.append(toViewController)
        self.navigationController.setViewControllers(vcs, animated: true)
    }

    open func cleanStackWhenPush(to toViewController: UIViewController) {
        self.navigationController.setViewControllers([toViewController], animated: true)
    }

    open func isVisible(controllerName: String) -> Bool {
        if let className = NSClassFromString(controllerName),
           let isCurrent = navigationController.visibleViewController?.isKind(of: className),
           isCurrent {
            return true
        }
        return false
    }

}
