//
//  DashboardViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class DashboardViewController: BaseViewController {

    private var viewModel: DashboardViewModel!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = false
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(DashboardMovementTableViewCell.self)
        tableView.register(DashboardMovementHeaderView.self)
        tableView.register(DashboardStockGraphTableViewCell.self)
        tableView.register(DashboardSalesGraphTableViewCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.input.fetchData.onNext(())
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = false
        showSideMenuButton()
        view.backgroundColor = UIColor.mainBgColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview().offset(17)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.right.equalToSuperview().offset(-17)
        }
    }

    override func localizeItems() {
        self.title = Localization.Dashboard.pageTitle
        tableView.reloadData()
    }

    func configure(with viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        viewModel.output.showLoading.subscribe(onNext: { [weak self] (loading) in
            if loading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }).disposed(by: disposeBag)

        viewModel.output.updateData.subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.output.onAPIError.subscribe(onNext: { [weak self] (error) in
            self?.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)
    }

}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.datasource.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel.datasource.sectionAt(index: section) else { return 0 }
        return viewModel.datasource.numberOfRowIn(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .movementList:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardMovementTableViewCell
            cell.layer.zPosition = CGFloat(indexPath.row + 1)
            if let data = viewModel.datasource.movementDataAt(index: indexPath.row) {
                cell.configure(withData: data, index: indexPath.row)
            }
            return cell

        case .stockGraph:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardStockGraphTableViewCell
            if let data = viewModel.datasource.stockData() {
                cell.configure(data: data)
            }
            return cell
            
        case .topSales:
            return UITableViewCell()
        case .topCategory:
            return UITableViewCell()

        case .salesGraph:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardSalesGraphTableViewCell
            if let data = viewModel.datasource.salesData() {
                cell.configure(data: data)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel.datasource.sectionAt(index: section) else {
            return nil
        }

        switch section {
        case .movementList:
            let header = tableView.dequeueReusableHeaderFooter() as DashboardMovementHeaderView
            header.layer.zPosition = 0
            if let data = viewModel.datasource.movementHeaderData() {
                header.configure(data: data)
            }
            return header

        default: return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = viewModel.datasource.sectionAt(index: section) else {
            return CGFloat.leastNormalMagnitude
        }

        switch section {
        case .movementList:
            return UITableView.automaticDimension

        default: return CGFloat.leastNormalMagnitude
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}
