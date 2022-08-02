//
//  ReportListViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class ReportListViewController: BaseViewController {

    private var viewModel: ReportListViewModel!

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
        tableView.register(ReportListLinkTableViewCell.self)
        tableView.register(ReportListLinkTableHeaderView.self)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
            make.left.equalToSuperview().offset(17)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.right.equalToSuperview().offset(-17)
        }
    }

    override func localizeItems() {
        self.title = Localization.ReportList.pageTitle
        tableView.reloadData()
    }

    func configure(with viewModel: ReportListViewModel) {
        self.viewModel = viewModel
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        mappingEvent(
            loading: viewModel.output.showLoading,
            andAPIError: viewModel.output.onAPIError
        )

        viewModel.output.updateData.subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

extension ReportListViewController: UITableViewDelegate, UITableViewDataSource {

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
        case .link:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ReportListLinkTableViewCell
            if let data = viewModel.datasource.linkAt(index: indexPath.row) {
                cell.configure(data: data)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section) else { return }

        switch section {
        case .link:
            guard let linkData = viewModel.datasource.linkAt(index: indexPath.row) else { return }
            SelectLinkOptionViewController.showSelectLinkOption(using: self) { [weak self] (choice) in
                guard let self = self else { return }

                switch choice {
                case .open:
                    WebViewViewController.openWebsite(url: linkData.url, using: self)
                case .share:
                    self.shareText(linkData.url)
                case .copyUrl:
                    UIPasteboard.general.string = linkData.url
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel.datasource.sectionAt(index: section) else {
            return nil
        }

        switch section {
        case .link:
            let header = tableView.dequeueReusableHeaderFooter() as ReportListLinkTableHeaderView
            return header
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = viewModel.datasource.sectionAt(index: section) else {
            return CGFloat.leastNormalMagnitude
        }

        switch section {
        case .link:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}
