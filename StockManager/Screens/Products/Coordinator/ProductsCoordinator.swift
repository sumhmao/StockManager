//
//  ProductsCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 20/6/2565 BE.
//

import Foundation
import RxSwift

final class ProductsCoordinator: BaseCoordinator {

    private var productsViewController: ProductsViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = ProductsViewModel()
        productsViewController = ProductsViewController()
        productsViewController.configure(with: viewModel)
        navigationController.setViewControllers([productsViewController], animated: false)
    }

}
