//
//  DashboardSalesGraphTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import UIKit
import AAInfographics

final class DashboardSalesGraphTableViewCell: UITableViewCell {

    private let chartFont = UIFont.sukhumvitTadmai(ofSize: 10)

    private lazy var headerView: DashboardHeaderTitleView = {
        let view = DashboardHeaderTitleView()
        return view
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .gray)
        loading.hidesWhenStopped = true
        loading.startAnimating()
        return loading
    }()

    private lazy var chartView: AAChartView = {
        let chartView = AAChartView()
        chartView.isScrollEnabled = false
        chartView.delegate = self
        return chartView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        selectionStyle = .none
        backgroundColor = .clear
        applyShadow(position: .bottom(offset: 1))
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.addSubview(headerView)
        contentView.addSubview(chartView)
        contentView.addSubview(loadingIndicator)

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        chartView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(24.44)
            make.bottom.equalToSuperview().offset(-9.57)
            make.right.equalToSuperview().offset(-25.66)
            make.height.equalTo(277.55)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(chartView)
        }
    }

    func configure(data: DashboardReportSalesGraphDisplayViewModel) {
        headerView.configure(title: data.salesData.title, filter: data.filter)

        let gradientColor = AAGradientColor.linearGradient(
            direction: .toBottom,
            stops: [
                [0.0, "#5C78DFFF"],
                [1.0, "#5C78DF00"]
            ]
        )

        let categories = data.salesData.list.map { item -> String in
            return item.name
        }
        let valueData = data.salesData.list.map { item -> Double in
            return item.valueList.first?.value ?? 0
        }

        let chartModel = AAChartModel()
            .chartType(.areaspline)
            .categories(categories)
            .yAxisTitle("")
            .backgroundColor(AAColor.white)
            .markerRadius(0)
            .legendEnabled(false)
            .dataLabelsEnabled(false)
            .series([
                AASeriesElement()
                    .name(data.salesData.title)
                    .color(gradientColor)
                    .data(valueData),
                ])

        chartView.aa_drawChartWithChartModel(chartModel)
    }

}

extension DashboardSalesGraphTableViewCell: AAChartViewDelegate {

    func aaChartViewDidFinishLoad(_ aaChartView: AAChartView) {
        loadingIndicator.stopAnimating()
    }

}
