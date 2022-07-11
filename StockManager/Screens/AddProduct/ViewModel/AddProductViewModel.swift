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

        onSave.withLatestFrom(Observable.combineLatest(productId, productName, buyingPrice, sellingPrice,
                                                       barcode, productImage))
            .subscribe(onNext: { [weak self] (code, name, buyPrice, sellPrice, barcode, productImage) in

                guard let code = code, let name = name, let buyPrice = buyPrice, let sellPrice = sellPrice else {
                    return
                }
                guard let buyingPrice = Double(buyPrice), let sellingPrice = Double(sellPrice) else {
                    return
                }
                
                self?.insertProduct(code: code, name: name, buyingPrice: buyingPrice, sellingPrice: sellingPrice,
                                    barCode: barcode, image: productImage?.jpegData(compressionQuality: 1))
        }).disposed(by: disposeBag)
    }

    private func insertProduct(code: String, name: String, buyingPrice: Double, sellingPrice: Double,
                               barCode: String? = nil, image: Data? = nil) {

        showLoading.onNext(true)
        var imageUpload: [ImageUpload]?
        if let image = image {
            imageUpload = [ImageUpload(data: image, fieldName: "image")]
        }
        let request = InsertProductEndpoint.Request(code: code, name: name, purchaseprice: buyingPrice,
                                                    sellprice: sellingPrice, barcode: barCode)

        InsertProductEndpoint.service.request(parameters: request, imageUpload: imageUpload)
            .subscribe(onNext: { [weak self] (_) in
            self?.showLoading.onNext(false)
            self?.onCompletion.onNext(())
        }, onError: { [weak self] (error) in
            self?.showLoading.onNext(false)
            self?.onAPIError.onNext(error)
        }).disposed(by: disposeBag)
    }

}
