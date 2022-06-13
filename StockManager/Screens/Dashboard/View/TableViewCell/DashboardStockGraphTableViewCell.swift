//
//  DashboardStockGraphTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 14/6/2565 BE.
//

import UIKit

final class DashboardStockGraphTableViewCell: UITableViewCell {

    private let chartFont = UIFont.sukhumvitTadmai(ofSize: 10)

    private lazy var pieChartView: ZortPieChartView = {
        let chart = ZortPieChartView()
        return chart
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
        contentView.addSubview(pieChartView)

        pieChartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11.65)
            make.left.equalToSuperview().offset(14.66)
            make.bottom.equalToSuperview().offset(-16.1)
            make.right.equalToSuperview().offset(-11)
            make.height.equalTo(176.25)
        }
    }

    func configure(data: ReportStockGraphData) {
        let entries = data.list.map { item -> ZortPieChartSegment in
            return ZortPieChartSegment(title: item.name, value: item.value)
        }
        pieChartView.setSegments(entries)
    }

}
