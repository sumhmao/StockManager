//
//  SelectLinkOptionViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import UIKit
import RxCocoa
import RxSwift

enum LinkMenu: CaseIterable {
    case open
    case share
    case copyUrl

    var title: String {
        switch self {
        case .open:
            return Localization.ReportList.openLink
        case .share:
            return Localization.ReportList.shareLink
        case .copyUrl:
            return Localization.ReportList.copyLink
        }
    }

    var icon: UIImage? {
        switch self {
        case .open:
            return UIImage(named: "open_link")
        case .share:
            return UIImage(named: "share_link")
        case .copyUrl:
            return UIImage(named: "copy_link")
        }
    }
}

final class SelectLinkOptionViewController: BaseViewController {

    static func showSelectLinkOption(using viewController: UIViewController, completion: @escaping (LinkMenu) -> Void) {
        let optionViewController = SelectLinkOptionViewController()
        optionViewController.modalTransitionStyle = .crossDissolve
        optionViewController.modalPresentationStyle = .overCurrentContext
        optionViewController.completion = completion
        viewController.present(optionViewController, animated: true)
    }

    private var completion: ((LinkMenu) -> Void)?

    private lazy var backPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var itemStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .fill
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
    }

    private func initUIComponents() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addSubview(backPanel)
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 13
        backPanel.addSubview(bgView)
        backPanel.addSubview(itemStackView)

        backPanel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        itemStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(28)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-25)
            make.right.equalToSuperview().offset(-28)
        }
        bgView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(itemStackView)
        }

        let allMenu = LinkMenu.allCases
        for i in 0..<allMenu.count {
            let menu = allMenu[i]
            let menuView = generateOptionItem(menu: menu, lastItem: i == (allMenu.count - 1))
            itemStackView.addArrangedSubview(menuView)
        }

        let dismissView = UIView()
        dismissView.backgroundColor = .clear
        dismissView.isUserInteractionEnabled = true
        view.addSubview(dismissView)
        dismissView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(backPanel.snp.top)
        }
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        dismissView.addGestureRecognizer(tap)
    }

    private func generateOptionItem(menu: LinkMenu, lastItem: Bool) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-13)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(22)
        }

        let title = UILabel()
        title.backgroundColor = .clear
        title.numberOfLines = 1
        title.font = .sukhumvitTadmai(ofSize: 17)
        title.textColor = .gray600
        title.text = menu.title
        stackView.addArrangedSubview(title)

        let iconView = UIImageView()
        iconView.backgroundColor = .clear
        iconView.contentMode = .scaleAspectFit
        iconView.image = menu.icon
        iconView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        stackView.addArrangedSubview(iconView)

        if !lastItem {
            let separator = UIView()
            separator.backgroundColor = .gray300
            view.addSubview(separator)
            separator.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
        }

        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] (_) in
            self?.dismiss(animated: true, completion: {
                self?.completion?(menu)
            })
        }).disposed(by: disposeBag)
        view.addGestureRecognizer(tap)

        return view
    }

}
