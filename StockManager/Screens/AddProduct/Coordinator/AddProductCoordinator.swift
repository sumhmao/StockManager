//
//  AddProductCoordinator.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/6/2565 BE.
//

import Foundation
import RxSwift

final class AddProductCoordinator: BaseCoordinator {

    private var addProductViewController: AddProductViewController!
    private let disposeBag = DisposeBag()
    private weak var completionViewController: UIViewController?
    private var completion: CompletionHandler?

    override func start() {
        completionViewController = navigationController.topViewController
        let viewModel = AddProductViewModel()
        
        viewModel.output.onCompletion.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if let completionVC = self.completionViewController {
                self.navigationController.popToViewController(completionVC, animated: true)
            }
            self.completion?()
        }).disposed(by: disposeBag)

        addProductViewController = AddProductViewController()
        addProductViewController.configure(with: viewModel)
        navigationController.pushViewController(addProductViewController, animated: true)
    }

    func setCompletion(_ completion: @escaping CompletionHandler) {
        self.completion = completion
    }

}
