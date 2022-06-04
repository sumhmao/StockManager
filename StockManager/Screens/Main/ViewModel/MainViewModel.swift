//
//  MainViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation
import RxSwift

final class MainViewModel: ViewModelType {

    struct Input {
        let username: AnyObserver<String?>
        let password: AnyObserver<String?>
        let loginTap: AnyObserver<Void>
    }
    struct Output {
        let showLoading: Observable<Bool>
        let loginSucceed: Observable<Void>
        let onAPIError: Observable<Error>
    }

    let input: Input
    let output: Output

    private let disposeBag = DisposeBag()
    private let username = BehaviorSubject<String?>(value: nil)
    private let password = BehaviorSubject<String?>(value: nil)
    private let loginTap = PublishSubject<Void>()

    private let showLoading = PublishSubject<Bool>()
    private let loginSucceed = PublishSubject<Void>()
    private let onAPIError = PublishSubject<Error>()

    init() {
        self.input = Input(
            username: self.username.asObserver(),
            password: self.password.asObserver(),
            loginTap: self.loginTap.asObserver()
        )
        self.output = Output(
            showLoading: self.showLoading.asObservable(),
            loginSucceed: self.loginSucceed.asObservable(),
            onAPIError: self.onAPIError.asObservable()
        )

        loginTap.withLatestFrom(Observable.combineLatest(username, password))
            .subscribe(onNext: { [weak self] (username, password) in
                guard let username = username, let password = password else { return }
                self?.login(username: username, password: password)
            }).disposed(by: disposeBag)
    }

    private func login(username: String, password: String) {
        showLoading.onNext(true)

        let param = LoginEndpoint.Request(username: username, password: password)
        LoginEndpoint.service.request(parameters: param).subscribe(onNext: { [weak self] (response) in
            self?.showLoading.onNext(false)
            let merchant = Merchant(withResponse: response)
            UserContext.shared.saveMerchant(merchant)
            self?.loginSucceed.onNext(())
        }, onError: { [weak self] (error) in
            self?.showLoading.onNext(false)
            self?.onAPIError.onNext(error)
        }).disposed(by: disposeBag)
    }
    
}

fileprivate extension Merchant {

    init(withResponse response: LoginEndpoint.Response) {
        self.userId = response.userid
        self.merchantId = response.merchantid
        self.name = response.merchantname ?? ""
        self.displayName = response.displayname ?? ""
    }

}
