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
    func productDataAt(index: Int) -> ProductItemDisplayViewModel?
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
    private var allProducts = [ProductItemDisplayViewModel]()

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
        allProducts.removeAll()
        updateData.onNext(())

        guard let text = text, text.trim().count > 0 else { return }
        showLoading.onNext(true)

        let param = GetProductListEndpoint.Request(searchText: text)
        GetProductListEndpoint.service.request(parameters: param).subscribe(onNext: { [weak self] (response) in
            let products = response.product.map { (product) -> ProductItemDisplayViewModel in
                return ProductItemDisplayViewModel(response: product)
            }
            self?.allProducts.append(contentsOf: products)
            self?.showLoading.onNext(false)
            self?.updateData.onNext(())
        }, onError: { [weak self] (error) in
            self?.showLoading.onNext(false)
            self?.onAPIError.onNext(error)
        }).disposed(by: disposeBag)
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
            return allProducts.count
        case .empty:
            return allProducts.count > 0 ? 0 : 1
        }
    }

    func productDataAt(index: Int) -> ProductItemDisplayViewModel? {
        guard index >= 0, index < allProducts.count else { return nil }
        return allProducts[index]
    }
}

extension ProductItemDisplayViewModel {

    init(response: GetProductListEndpoint.Product) {
        self.id = response.code ?? ""
        self.title = response.name ?? ""
        self.imageUrl = response.imagepath
        self.stock = response.stock ?? 0
        self.available = response.availablestock ?? 0
        self.deleted = (response.isdeleted ?? 0).boolValue
    }

}
