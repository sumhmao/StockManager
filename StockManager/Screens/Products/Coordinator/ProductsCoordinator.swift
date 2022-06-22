//
//  ProductsCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 20/6/2565 BE.
//

import Foundation
import RxSwift

final class ProductsCoordinator: BaseCoordinator {

    let toAddProduct = PublishSubject<CompletionHandler>()
    private var productsViewController: ProductsViewController!
    private let disposeBag = DisposeBag()

    override func start() {
        let viewModel = ProductsViewModel()
        viewModel.output.toAddProduct.map { [weak viewModel] () -> CompletionHandler in
            return { () -> Void in
                viewModel?.input.refreshData.onNext(())
            }
        }.bind(to: toAddProduct).disposed(by: disposeBag)
        productsViewController = ProductsViewController()
        productsViewController.configure(with: viewModel)
        navigationController.setViewControllers([productsViewController], animated: false)
    }

}
