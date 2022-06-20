//
//  ProductsViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 20/6/2565 BE.
//

import Foundation
import RxSwift

enum ProductsDataSection: Int, CaseIterable {
    case product = 0
    case empty = 1
}

protocol ProductsDataSource {
    func numberOfSections() -> Int
    func sectionAt(index: Int) -> ProductsDataSection?
    func numberOfRowIn(section: ProductsDataSection) -> Int
}

final class ProductsViewModel: ViewModelType {

    struct Input {
        let searchText: AnyObserver<String?>
    }
    struct Output {
        let showLoading: Observable<Bool>
        let updateData: Observable<Void>
        let onAPIError: Observable<Error>
    }

    let input: Input
    let output: Output
    var datasource: ProductsDataSource { return self }

    private let disposeBag = DisposeBag()
    private let searchText = BehaviorSubject<String?>(value: nil)
    private let showLoading = PublishSubject<Bool>()
    private let updateData = PublishSubject<Void>()
    private let onAPIError = PublishSubject<Error>()

    init() {
        self.input = Input(
            searchText: searchText.asObserver()
        )
        self.output = Output(
            showLoading: self.showLoading.asObservable(),
            updateData: self.updateData.asObservable(),
            onAPIError: self.onAPIError.asObservable()
        )

        searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (text) in
                self?.doSearch(text: text)
            }).disposed(by: disposeBag)
    }

    private func doSearch(text: String?) {
        guard let text = text, text.trim().count > 0 else {
            return
        }

        showLoading.onNext(true)
        updateData.onNext(())
    }

}

extension ProductsViewModel: ProductsDataSource {

    func numberOfSections() -> Int {
        return ProductsDataSection.allCases.count
    }

    func sectionAt(index: Int) -> ProductsDataSection? {
        return ProductsDataSection(rawValue: index)
    }

    func numberOfRowIn(section: ProductsDataSection) -> Int {
        switch section {
        case .product:
            return 0
        case .empty:
            return 1
        }
    }
}
