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

}
