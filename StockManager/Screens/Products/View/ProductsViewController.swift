//
//  ProductsViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 20/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class ProductsViewController: BaseViewController {

    private var viewModel: ProductsViewModel!

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 17
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var searchBar: ZortTextField = {
        let textfield = ZortTextField()
        textfield.mode = .searchbar
        textfield.placeholder = Localization.Products.searchHint
        textfield.leftImage = UIImage(named: "search_icon")
        return textfield
    }()

    private lazy var contentPanel: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.clipsToBounds = false
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(ProductEmptyStateTableViewCell.self)
        tableView.register(ProductTableHeaderView.self)
        tableView.register(ProductItemTableViewCell.self)
        tableView.register(ZortLazyLoadingTableViewCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = false
        showSideMenuButton()
        showAddButton()
        view.backgroundColor = UIColor.mainBgColor
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(contentPanel)
        contentPanel.addSubview(tableView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(-17)
        }
        contentPanel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().offset(-22)
            make.right.equalToSuperview().offset(-17)
        }
    }

    override func localizeItems() {
        self.title = Localization.Products.pageTitle
        tableView.reloadData()
    }

    override func onAddButtonPressed() {

    }

    func configure(with viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        searchBar.rx.text.bind(to: viewModel.input.searchText).disposed(by: disposeBag)

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

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {

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
        case .product:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ProductItemTableViewCell
            if let data = viewModel.datasource.productDataAt(index: indexPath.row) {
                cell.configure(withData: data)
            }
            return cell

        case .loadMore:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ZortLazyLoadingTableViewCell
            return cell

        case .empty:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ProductEmptyStateTableViewCell
            cell.configure()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section) else { return }
        switch section {
        case .loadMore:
            viewModel.input.fetchMoreData.onNext(())
        default: break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section) else { return 0 }

        switch section {
        case .product:
            return UITableView.automaticDimension
        case .loadMore:
            return UITableView.automaticDimension
        case .empty:
            return tableView.bounds.height
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel.datasource.sectionAt(index: section) else { return nil }

        switch section {
        case .product:
            guard viewModel.datasource.numberOfRowIn(section: section) > 0 else { return nil }
            return tableView.dequeueReusableHeaderFooter() as ProductTableHeaderView
            
        default : return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = viewModel.datasource.sectionAt(index: section) else {
            return CGFloat.leastNormalMagnitude
        }

        switch section {
        case .product:
            guard viewModel.datasource.numberOfRowIn(section: section) > 0 else {
                return CGFloat.leastNormalMagnitude
            }
            return UITableView.automaticDimension

        default: return CGFloat.leastNormalMagnitude
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}
