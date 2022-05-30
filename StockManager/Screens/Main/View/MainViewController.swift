//
//  MainViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import UIKit
import RxSwift
import SnapKit

final class MainViewController: StackButtonViewController {

    private var viewModel: MainViewModel!

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "zort_logo")
        imageView.heightAnchor.constraint(equalToConstant: 126.62).isActive = true
        return imageView
    }()

    private lazy var emailTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        return textField
    }()

    private lazy var passwordTextField: ZortTextField = {
        let textField = ZortTextField()
        textField.isUserInteractionEnabled = true
        textField.validation = { (text) -> Bool in
            guard let text = text else { return false }
            return text.trim().count > 0
        }
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        addValidation()
        localizeItems()
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.mainBgColor
        configureLayout(contentInsets: UIEdgeInsets(top: 136, left: 57, bottom: 20, right: 57))
        hideButtonSection(hide: true)
        addContent(view: logoView, spaceAfter: 59.38)
        addContent(view: emailTextField, spaceAfter: 16)
        addContent(view: passwordTextField)
    }

    private func addValidation() {
//        let isButtonEnable = Observable<Bool>.combineLatest(
//            emailTextField.validateState.share(replay: 1, scope: .whileConnected),
//            passwordTextField.validateState.share(replay: 1, scope: .whileConnected)
//        ) {
//            (email, password) in
//            return (email == .passed) && (password == .passed)
//        }
//        isButtonEnable.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
    }

    override func localizeItems() {
        emailTextField.placeholder = Localization.Main.emailHint
        passwordTextField.placeholder = Localization.Main.passwordHint
    }

    func configure(with viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

}
