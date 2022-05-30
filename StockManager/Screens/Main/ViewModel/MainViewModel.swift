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

    }
    struct Output {
        
    }

    let input: Input
    let output: Output

    private let disposeBag = DisposeBag()

    init() {
        self.input = Input(

        )
        self.output = Output(

        )
    }
}
