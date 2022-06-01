//
//  LoadingController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import UIKit
import SnapKit

final class LoadingController: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        return indicator
    }()

    private lazy var loadingText: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSukhumvitTadmai(ofSize: 18)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.addSubview(stackView)
        stackView.addArrangedSubview(loadingIndicator)
        stackView.addArrangedSubview(loadingText)

        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }

    private func showUsing(vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        UIApplication.shared.statusBarUIView?.isHidden = true
        UIView.transition(with: vc.view, duration: 0.25, options: [.transitionCrossDissolve], animations: { [weak self] in
            guard let self = self else { return }
            vc.view.addSubview(self)
            self.snp.makeConstraints { make in
                make.top.left.bottom.right.equalToSuperview()
            }
        }, completion: { (_) in
            completion?()
        })
    }

    private func hide(animated: Bool, completion: (() -> Void)?) {
        UIApplication.shared.statusBarUIView?.isHidden = false
        guard let superview = self.superview else {
            removeFromSuperview()
            completion?()
            return
        }
        UIView.transition(with: superview, duration: 0.25, options: [.transitionCrossDissolve], animations: { [weak self] in
          self?.removeFromSuperview()
        }, completion: { (_) in
            completion?()
        })
    }

    public static func showLoading(title: String? = Localization.Shared.loading, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let rootView = UIApplication.shared.topMostViewController else { return }
        let alert = LoadingController()
        alert.loadingText.text = title

        if firstLoadingView == nil {
            alert.showUsing(vc: rootView, animated: animated, completion: completion)
        } else {
            completion?()
        }
    }

    private static var firstLoadingView: LoadingController? {
        guard let rootView = UIApplication.shared.topMostViewController,
              let alert = rootView.view.subviews.first(where: {
                ($0 is LoadingController)
              }) as? LoadingController else {
            return nil
        }
        return alert
    }

    public static func hideLoading(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let alert = firstLoadingView else {
            completion?()
            return
        }
        alert.hide(animated: animated, completion: completion)
    }

}
