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
    case summary = 2
    case salesGraph = 3
}

protocol DashboardDataSource {
    func numberOfSections() -> Int
    func sectionAt(index: Int) -> DashboardDataSection?
    func numberOfRowIn(section: DashboardDataSection) -> Int
    func movementDataAt(index: Int) -> ReportMovementData.MovementItem?
    func movementHeaderData() -> DashboardMovementHeaderDisplayViewModel?
    func stockData() -> DashboardReportStockGraphDisplayViewModel?
    func summaryDataAt(index: Int) -> DashboardSummaryItemDisplayViewModel?
    func salesData() -> DashboardReportSalesGraphDisplayViewModel?
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
    private var salesGraphData: ReportSalesGraphData?
    private var summaryItems = [DashboardSummaryItemDisplayViewModel]()

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
        summaryItems.removeAll()
        salesGraphData = nil
        updateData.onNext(())

        let fetchMovementParam = GetMovementListEndpoint.Request()
        let fetchMovementRequest = GetMovementListEndpoint.service.request(parameters: fetchMovementParam)

        let stockGraphParam = GetDashboardStockGraphEndpoint.Request()
        let stockGraphRequest = GetDashboardStockGraphEndpoint.service.request(parameters: stockGraphParam)

        let dashboardSummaryParam = GetDashboardSummaryEndpoint.Request()
        let dashboardSummaryRequest = GetDashboardSummaryEndpoint.service.request(parameters: dashboardSummaryParam)

        let salesGraphParam = GetDashboardSalesGraphEndpoint.Request()
        let salesGraphRequest = GetDashboardSalesGraphEndpoint.service.request(parameters: salesGraphParam)

        Observable.combineLatest(fetchMovementRequest, stockGraphRequest, dashboardSummaryRequest, salesGraphRequest)
            .subscribe(onNext: { [weak self] (movement, stockGraph, summary, salesGraph) in
                guard let self = self else { return }
                self.movementData = ReportMovementData(response: movement)
                self.stockGraphData = ReportStockGraphData(response: stockGraph)
                self.initSummaryData(response: summary)
                self.salesGraphData = ReportSalesGraphData(response: salesGraph)
                self.showLoading.onNext(false)
                self.updateData.onNext(())

            }, onError: { [weak self] (error) in
                self?.showLoading.onNext(false)
                self?.onAPIError.onNext(error)
            }).disposed(by: disposeBag)
    }

    private func initSummaryData(response: GetDashboardSummaryEndpoint.Response) {
        if let id = response.name1id, let name = response.name1, let value = response.name1value {
            let summaryItem = DashboardSummaryItemDisplayViewModel(id: id, name: name, value: value)
            summaryItems.append(summaryItem)
        }
        if let id = response.name2id, let name = response.name2, let value = response.name2value {
            let summaryItem = DashboardSummaryItemDisplayViewModel(id: id, name: name, value: value)
            summaryItems.append(summaryItem)
        }
        if let id = response.name3id, let name = response.name3, let value = response.name3value {
            let summaryItem = DashboardSummaryItemDisplayViewModel(id: id, name: name, value: value)
            summaryItems.append(summaryItem)
        }
        if let id = response.name4id, let name = response.name4, let value = response.name4value {
            let summaryItem = DashboardSummaryItemDisplayViewModel(id: id, name: name, value: value)
            summaryItems.append(summaryItem)
        }
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
        case .summary:
            return summaryItems.count
        case .salesGraph:
            return salesGraphData == nil ? 0 : 1
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

    func stockData() -> DashboardReportStockGraphDisplayViewModel? {
        guard let stockData = stockGraphData else { return nil }
        return DashboardReportStockGraphDisplayViewModel(stockData: stockData, filter: "Label")
    }

    func summaryDataAt(index: Int) -> DashboardSummaryItemDisplayViewModel? {
        guard index >= 0, index < summaryItems.count else { return nil }
        return summaryItems[index]
    }

    func salesData() -> DashboardReportSalesGraphDisplayViewModel? {
        guard let salesData = salesGraphData else { return nil }
        return DashboardReportSalesGraphDisplayViewModel(salesData: salesData, filter: "Label")
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

fileprivate extension ReportSalesGraphData {

    init(response: GetDashboardSalesGraphEndpoint.Response) {
        self.title = response.name ?? ""
        self.list = response.list.map { item in
            let valueList = item.valuelist.map { value in
                return ReportSalesGraphData.SalesGraphItem.ValueItem(
                    detailId: value.detailid, name: value.name, value: value.value
                )
            }
            return ReportSalesGraphData.SalesGraphItem(
                name: item.name, value1: item.value1, value2: item.value2, valueList: valueList
            )
        }
    }

}
