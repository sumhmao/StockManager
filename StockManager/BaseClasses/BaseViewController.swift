//
//  BaseViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    private(set) var viewRendered = false

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.rx
            .notification(Notification.Name.kLanguageChange)
            .subscribe(onNext: { [weak self] (notification) in
                guard let strongSelf = self, strongSelf.viewRendered else { return }
                strongSelf.localizeItems()
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewRendered = true
    }

    func showBackButton() {
        let backBtn = UIBarButtonItem(image: UIImage(named: "back_arrow"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onBackPressed))
        backBtn.tintColor = .white
        navigationItem.leftBarButtonItem = backBtn
    }

    @objc func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }

    func showSideMenuButton() {
        let menuBtn = UIBarButtonItem(image: UIImage(named: "hamburger"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onSideMenuPressed))
        menuBtn.tintColor = .white
        navigationItem.leftBarButtonItem = menuBtn
    }

    @objc func onSideMenuPressed() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: AppCoordinator.sideMenuNotificationKey),
                                        object: nil)
    }

    func showAddButton() {
        let addBtn = UIBarButtonItem(image: UIImage(named: "nav_add_button"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(onAddButtonPressed))
       addBtn.tintColor = .white
       navigationItem.rightBarButtonItem = addBtn
    }

    @objc func onAddButtonPressed() {}

    func localizeItems() {}

    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    func showLoading(completion: (() -> Void)? = nil) {
        LoadingController.showLoading(completion: completion)
    }

    func hideLoading(completion: (() -> Void)? = nil) {
        LoadingController.hideLoading(completion: completion)
    }

    func mappingEvent(loading: Observable<Bool>, andAPIError error: Observable<Error>) {
        loading.subscribe(onNext: { [weak self] (isLoading) in
            if isLoading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }).disposed(by: disposeBag)

        error.subscribe(onNext: { [weak self] (apiError) in
            self?.showAlert(title: "Error", message: apiError.localizedDescription)
        }).disposed(by: disposeBag)
    }

}
