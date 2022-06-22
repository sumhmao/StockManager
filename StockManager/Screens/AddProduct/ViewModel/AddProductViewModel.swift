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
    private let onSave = PublishSubject<Void>()
    private let showLoading = PublishSubject<Bool>()
    private let onAPIError = PublishSubject<Error>()
    private let onCompletion = PublishSubject<Void>()

    init() {
        self.input = Input(
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
