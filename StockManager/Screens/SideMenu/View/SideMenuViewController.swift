//
//  SideMenuViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/6/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class SideMenuViewController: BaseViewController {

    private var viewModel: SideMenuViewModel!

    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(SideMenuShopTableViewCell.self)
        tableView.register(SideMenuItemTableViewCell.self)
        return tableView
    }()

    private lazy var logoutButton: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var logoutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .sukhumvitTadmai(ofSize: 14)
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.menuTableView.snp.removeConstraints()
            self.menuTableView.snp.makeConstraints { make in
                make.top.left.equalToSuperview()
                make.bottom.equalTo(self.logoutButton.snp.top)
                make.width.equalToSuperview().multipliedBy(0.66)
            }
            self.menuTableView.superview?.layoutIfNeeded()
        }
    }

    private func initUIComponents() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        view.addSubview(menuTableView)
        view.addSubview(logoutButton)
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        logoutButton.addSubview(logoutLabel)

        menuTableView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalTo(logoutButton.snp.top)
            make.width.equalTo(0)
        }
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(39)
            make.left.right.equalTo(menuTableView)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        logoutLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.centerY.equalToSuperview()
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.right.equalTo(menuTableView)
            make.bottom.equalToSuperview()
        }

        let clearView = UIView()
        clearView.backgroundColor = .clear
        view.addSubview(clearView)
        let tapToDismiss = UITapGestureRecognizer()
        tapToDismiss.rx.event.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        clearView.isUserInteractionEnabled = true
        clearView.addGestureRecognizer(tapToDismiss)
        clearView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(menuTableView.snp.right)
        }
    }

    override func localizeItems() {
        menuTableView.reloadData()
        logoutLabel.text = Localization.SideMenuTitle.logout
    }

    func configure(with viewModel: SideMenuViewModel) {
        self.viewModel = viewModel
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.reloadData()

        viewModel.output.dataUpdate.subscribe(onNext: { [weak self] (_) in
            self?.menuTableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.output.menuTap.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)

        let logoutTap = UITapGestureRecognizer()
        logoutTap.rx.event.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true)
            self?.viewModel.input.didTapLogout.onNext(())
        }).disposed(by: disposeBag)
        logoutButton.addGestureRecognizer(logoutTap)
    }

}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {

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
        case .shopName:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SideMenuShopTableViewCell
            cell.configure(withName: viewModel.datasource.shopName())
            return cell

        case .menu:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SideMenuItemTableViewCell
            if let data = viewModel.datasource.menuItemDataAt(index: indexPath.row) {
                cell.configure(withData: data)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section), section == .menu else { return }
        viewModel.input.didTapMenu.onNext(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = viewModel.datasource.sectionAt(index: indexPath.section) else { return 0 }
        switch section {
        case .shopName:
            return 170
        case .menu:
            return UITableView.automaticDimension
        }
    }
}
