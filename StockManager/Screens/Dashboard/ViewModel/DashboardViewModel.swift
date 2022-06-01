//
//  DashboardViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import RxSwift

final class DashboardViewModel: ViewModelType {

    struct Input {
        let logoutTap: AnyObserver<Void>
    }
    struct Output {

    }

    let input: Input
    let output: Output

    private let disposeBag = DisposeBag()
    private let logoutTap = PublishSubject<Void>()

    init() {
        self.input = Input(
            logoutTap: logoutTap.asObserver()
        )
        self.output = Output(

        )

        logoutTap.subscribe(onNext: { (_) in
            UserContext.shared.logout()
        }).disposed(by: disposeBag)
    }

}
