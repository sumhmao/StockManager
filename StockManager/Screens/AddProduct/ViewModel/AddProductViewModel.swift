//
//  AddProductViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/6/2565 BE.
//

import Foundation
import RxSwift

final class AddProductViewModel: ViewModelType {

    struct Input {
        let productId: AnyObserver<String?>
        let productName: AnyObserver<String?>
        let buyingPrice: AnyObserver<String?>
        let sellingPrice: AnyObserver<String?>
        let barcode: AnyObserver<String?>
        let productImage: AnyObserver<UIImage?>
        let onSave: AnyObserver<Void>
    }
    struct Output {
        let showLoading: Observable<Bool>
        let onAPIError: Observable<Error>
        let onCompletion: Observable<Void>
    }

    let input: Input
    let output: Output

    private let disposeBag = DisposeBag()
    private let productId = BehaviorSubject<String?>(value: nil)
    private let productName = BehaviorSubject<String?>(value: nil)
    private let buyingPrice = BehaviorSubject<String?>(value: nil)
    private let sellingPrice = BehaviorSubject<String?>(value: nil)
    private let barcode = BehaviorSubject<String?>(value: nil)
    private let productImage = BehaviorSubject<UIImage?>(value: nil)
    private let onSave = PublishSubject<Void>()
    private let showLoading = PublishSubject<Bool>()
    private let onAPIError = PublishSubject<Error>()
    private let onCompletion = PublishSubject<Void>()

    init() {
        self.input = Input(
            productId: productId.asObserver(),
            productName: productName.asObserver(),
            buyingPrice: buyingPrice.asObserver(),
            sellingPrice: sellingPrice.asObserver(),
            barcode: barcode.asObserver(),
            productImage: productImage.asObserver(),
            onSave: onSave.asObserver()
        )
        self.output = Output(
            showLoading: self.showLoading.asObservable(),
            onAPIError: self.onAPIError.asObservable(),
            onCompletion: self.onCompletion.asObservable()
        )

        onSave.subscribe(onNext: { [weak self] (_) in
            self?.onCompletion.onNext(())
        }).disposed(by: disposeBag)
    }

}
