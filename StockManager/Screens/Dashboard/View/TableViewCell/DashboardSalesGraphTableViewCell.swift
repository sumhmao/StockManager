//
//  DashboardSalesGraphTableViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import UIKit

final class DashboardSalesGraphTableViewCell: UITableViewCell {

    private let chartFont = UIFont.sukhumvitTadmai(ofSize: 10)

    private lazy var headerView: DashboardHeaderTitleView = {
        let view = DashboardHeaderTitleView()
        return view
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

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    func configure(data: DashboardReportSalesGraphDisplayViewModel) {
        headerView.configure(title: data.salesData.title, filter: data.filter)
    }

}
