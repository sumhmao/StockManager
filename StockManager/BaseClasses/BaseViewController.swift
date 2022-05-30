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

    func localizeItems() {}

}
