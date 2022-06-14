//
//  DashboardStockGraphTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 14/6/2565 BE.
//

import UIKit

final class DashboardStockGraphTableViewCell: UITableViewCell {

    private lazy var headerView: DashboardHeaderTitleView = {
        let view = DashboardHeaderTitleView()
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    private lazy var pieChartView: ZortPieChartView = {
        let chart = ZortPieChartView()
        return chart
    }()

    private lazy var legendTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(DashboardStockGraphLegendViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(pieChartView)
        stackView.addArrangedSubview(legendTableView)

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(14.66)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-11)
            make.height.equalTo(176.25)
        }
    }

    func configure(data: DashboardReportStockGraphDisplayViewModel) {
        headerView.configure(title: data.stockData.title, filter: data.filter)
        let entries = data.stockData.list.map { item -> ZortPieChartSegment in
            return ZortPieChartSegment(title: item.name, value: item.value)
        }
        pieChartView.setSegments(entries)
        legendTableView.reloadData()
    }

}

extension DashboardStockGraphTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pieChartView.segments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardStockGraphLegendViewCell
        if indexPath.row >= 0, indexPath.row < pieChartView.segments.count {
            let data = pieChartView.segments[indexPath.row]
            cell.configure(data: data)
        }
        return cell
    }

}
