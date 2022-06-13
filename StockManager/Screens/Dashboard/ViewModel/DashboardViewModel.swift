//
//  DashboardViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import RxSwift

enum DashboardDataSection: Int, CaseIterable {
    case movementList = 0
    case stockGraph = 1
    case topSales = 2
    case topCategory = 3
    case salesGraph = 4
}

protocol DashboardDataSource {
    func numberOfSections() -> Int
    func sectionAt(index: Int) -> DashboardDataSection?
    func numberOfRowIn(section: DashboardDataSection) -> Int
    func movementDataAt(index: Int) -> ReportMovementData.MovementItem?
    func movementHeaderData() -> DashboardMovementHeaderDisplayViewModel?
    func stockData() -> ReportStockGraphData?
}

final class DashboardViewModel: ViewModelType {

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
    var datasource: DashboardDataSource { return self }

    private let disposeBag = DisposeBag()
    private let fetchData = PublishSubject<Void>()
    private let showLoading = PublishSubject<Bool>()
    private let updateData = PublishSubject<Void>()
    private let onAPIError = PublishSubject<Error>()
    private var movementData: ReportMovementData?
    private var stockGraphData: ReportStockGraphData?

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
        movementData = nil
        stockGraphData = nil
        updateData.onNext(())

        let fetchMovementParam = GetMovementListEndpoint.Request()
        let fetchMovementRequest = GetMovementListEndpoint.service.request(parameters: fetchMovementParam)

        let stockGraphParam = GetDashboardStockGraphEndpoint.Request()
        let stockGraphRequest = GetDashboardStockGraphEndpoint.service.request(parameters: stockGraphParam)

        Observable.combineLatest(fetchMovementRequest, stockGraphRequest)
            .subscribe(onNext: { [weak self] (movement, stockGraph) in
                guard let self = self else { return }
                self.movementData = ReportMovementData(response: movement)
                self.stockGraphData = ReportStockGraphData(response: stockGraph)
                self.showLoading.onNext(false)
                self.updateData.onNext(())

            }, onError: { [weak self] (error) in
                self?.showLoading.onNext(false)
                self?.onAPIError.onNext(error)
            }).disposed(by: disposeBag)
    }

}

extension DashboardViewModel: DashboardDataSource {

    func numberOfSections() -> Int {
        return DashboardDataSection.allCases.count
    }

    func sectionAt(index: Int) -> DashboardDataSection? {
        return DashboardDataSection(rawValue: index)
    }

    func numberOfRowIn(section: DashboardDataSection) -> Int {
        switch section {
        case .movementList:
            return movementData?.list.count ?? 0
        case .stockGraph:
            return stockGraphData == nil ? 0 : 1
        case .topSales:
            return 0
        case .topCategory:
            return 0
        case .salesGraph:
            return 0
        }
    }

    func movementDataAt(index: Int) -> ReportMovementData.MovementItem? {
        guard let movement = movementData, index >= 0, index < movement.list.count else { return nil }
        return movement.list[index]
    }

    func movementHeaderData() -> DashboardMovementHeaderDisplayViewModel? {
        guard let movement = movementData else { return nil }
        return DashboardMovementHeaderDisplayViewModel(title: movement.title, filter: "Label")
    }

    func stockData() -> ReportStockGraphData? {
        return stockGraphData
    }
}

fileprivate extension ReportMovementData {

    init(response: GetMovementListEndpoint.Response) {
        self.title = response.name ?? ""
//        var count = 0
//        self.list = response.list.map { item in
//            count += 1
//            let lastItem = count == response.list.count
//            return ReportMovementData.MovementItem(
//                id: "A018695",
//                title: "Lorem Ipsum is simply dummy text",
//                imageUrl: "",
//                movement: "+100,000",
//                available: "100,000",
//                lastItem: lastItem
//            )
//        }

        let set = (0...4)
        self.list = set.map { item in
            let lastItem = item == set.last
            return ReportMovementData.MovementItem(
                id: "A018695",
                title: "Lorem Ipsum is simply dummy text",
                imageUrl: "",
                movement: "+100,000",
                available: "100,000",
                lastItem: lastItem
            )
        }
    }

}

fileprivate extension ReportStockGraphData {

    init(response: GetDashboardStockGraphEndpoint.Response) {
        self.title = response.name ?? ""
        self.list = response.list.map { item in
            return ReportStockGraphData.StockGraphItem(
                id: item.id,
                name: item.name ?? "",
                value: item.value
            )
        }
    }

}
