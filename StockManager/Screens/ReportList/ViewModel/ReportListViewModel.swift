//
//  ReportListViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import Foundation
import RxSwift

enum ReportListSection: Int, CaseIterable {
    case link = 0
}

protocol ReportListDataSource {
    func numberOfSections() -> Int
    func sectionAt(index: Int) -> ReportListSection?
    func numberOfRowIn(section: ReportListSection) -> Int
    func linkAt(index: Int) -> ReportLinkData?
}

final class ReportListViewModel: ViewModelType {

    struct Input {
        let fetchData: AnyObserver<Void>
    }
    struct Output {
        let showLoading: Observable<Bool>
        let updateData: Observable<Void>
        let onAPIError: Observable<Error>
    }

    let input: Input
    let output: Output
    var datasource: ReportListDataSource { return self }

    private let disposeBag = DisposeBag()
    private let fetchData = PublishSubject<Void>()
    private let showLoading = PublishSubject<Bool>()
    private let updateData = PublishSubject<Void>()
    private let onAPIError = PublishSubject<Error>()
    private var linkData = [ReportLinkData]()

    init() {
        self.input = Input(
            fetchData: fetchData.asObserver()
        )
        self.output = Output(
            showLoading: self.showLoading.asObservable(),
            updateData: self.updateData.asObservable(),
            onAPIError: self.onAPIError.asObservable()
        )

        fetchData.subscribe(onNext: { [weak self] (_) in
            self?.fetchDataFromAPI()
        }).disposed(by: disposeBag)
    }

    private func fetchDataFromAPI() {
        showLoading.onNext(true)
        linkData.removeAll()
        updateData.onNext(())

        // mock data
        linkData.append(ReportLinkData(title: "Test Report 1", url: "http://www.google.com"))
        linkData.append(ReportLinkData(title: "Test Report 2", url: "http://www.gmail.com"))
        updateData.onNext(())
        showLoading.onNext(false)
    }

}

extension ReportListViewModel: ReportListDataSource {

    func numberOfSections() -> Int {
        return ReportListSection.allCases.count
    }

    func sectionAt(index: Int) -> ReportListSection? {
        return ReportListSection(rawValue: index)
    }

    func numberOfRowIn(section: ReportListSection) -> Int {
        return linkData.count
    }

    func linkAt(index: Int) -> ReportLinkData? {
        guard index >= 0, index < linkData.count else { return nil }
        return linkData[index]
    }

}
