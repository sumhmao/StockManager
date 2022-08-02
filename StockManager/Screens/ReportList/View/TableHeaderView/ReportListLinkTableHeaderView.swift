//
//  ReportListLinkTableHeaderView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import UIKit

final class ReportListLinkTableHeaderView: UITableViewHeaderFooterView {

    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = Localization.ReportList.documentListHeader
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initUIComponent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponent()
    }

    private func initUIComponent() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(headerTitle)

        headerTitle.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }

}
