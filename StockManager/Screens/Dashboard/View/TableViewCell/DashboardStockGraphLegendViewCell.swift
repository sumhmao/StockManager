//
//  DashboardStockGraphLegendViewCell.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 14/6/2565 BE.
//

import UIKit

final class DashboardStockGraphLegendViewCell: UITableViewCell {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var legendColorView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .black
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 10)
        label.textColor = .black
        return label
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(legendColorView)
        stackView.setCustomSpacing(5, after: legendColorView)
        stackView.addArrangedSubview(percentLabel)
        stackView.setCustomSpacing(7, after: percentLabel)
        stackView.addArrangedSubview(nameLabel)

        stackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        percentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        legendColorView.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(10)
            make.centerY.equalTo(percentLabel)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(15)
        }
    }

    func configure(data: ZortPieChartSegment) {
        legendColorView.backgroundColor = data.color
        nameLabel.text = data.title

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        let percent = pFormatter.string(from: NSNumber(value: data.value * 100))
        percentLabel.text = percent
    }

}
