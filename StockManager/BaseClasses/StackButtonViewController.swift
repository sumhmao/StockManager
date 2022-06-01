//
//  StackButtonViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 30/5/2565 BE.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ContentStackView: UIStackView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        backgroundColor = .clear
        axis = .vertical
        alignment = .fill
        distribution = .fill
    }

    public func addContent(view: UIView, spaceAfter space: CGFloat? = nil) {
        addArrangedSubview(view)
        if let space = space {
            setCustomSpacing(space, after: view)
        }
    }

    public func clearAllContents() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }
    }

}

class StackButtonViewController: BaseViewController {

    private var topBgView: UIView?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var contentStackView: ContentStackView = {
        let stackview = ContentStackView()
        return stackview
    }()

    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = buttonPanel.backgroundColor
        return bottomView
    }()

    private lazy var buttonPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private(set) lazy var buttonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .clear
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.spacing = 16
        stackview.distribution = .fillEqually
        return stackview
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        initLayoutComponents()
    }

    private func initLayoutComponents() {
        view.addSubview(scrollView)
        view.addSubview(buttonPanel)
        view.addSubview(bottomView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        buttonPanel.addSubview(buttonStackView)

        bottomView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.bottom.right.equalToSuperview()
        }
        buttonPanel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonPanel.snp.top)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        contentStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }

    public func configureLayout(contentInsets: UIEdgeInsets? =  nil,
                                buttonInsets: UIEdgeInsets? = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
                                spaceBetween space: CGFloat? = nil, buttonSpace: CGFloat? = nil,
                                buttonAxis: NSLayoutConstraint.Axis = .vertical) {
        if let inset = contentInsets {
            contentStackView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(inset.top)
                make.left.equalToSuperview().offset(inset.left)
                make.bottom.equalToSuperview().offset(-inset.bottom)
                make.right.equalToSuperview().offset(-inset.right)
            }
        }
        if let inset = buttonInsets {
            buttonStackView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(inset.top)
                make.left.equalToSuperview().offset(inset.left)
                make.bottom.equalToSuperview().offset(-inset.bottom)
                make.right.equalToSuperview().offset(-inset.right)
            }
        }
        if let space = space {
            scrollView.snp.updateConstraints { make in
                make.bottom.equalTo(buttonPanel.snp.top).offset(-space)
            }
        }
        if let space = buttonSpace {
            buttonStackView.spacing = space
        }
        buttonStackView.axis = buttonAxis
    }

    public func addContent(view: UIView, spaceAfter space: CGFloat? = nil) {
        contentStackView.addContent(view: view, spaceAfter: space)
    }

    public func clearAllContents() {
        contentStackView.clearAllContents()
    }

    public func setContent(contentView: UIView) {
        view.insertSubview(contentView, at: 0)
        scrollView.removeFromSuperview()
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
        }
    }

    public func addButton(_ button: UIButton, height: CGFloat = 46) {
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        buttonStackView.addArrangedSubview(button)
    }

    public func hideButtonSection(hide: Bool) {
        buttonPanel.isHidden = hide
        bottomView.isHidden = hide
    }

    public func addScrollableTopBackground(color: UIColor) {
        topBgView?.removeFromSuperview()
        let view = UIView()
        view.backgroundColor = color
        contentView.insertSubview(view, at: 0)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
            make.height.equalTo(scrollView.snp.height)
        }
        topBgView = view
    }

    public func takeSnapshot(padding: UIEdgeInsets = .zero) -> UIImage? {
        if #available(iOS 13, *) {
            scrollView.snp.removeConstraints()
            scrollView.removeFromSuperview()
        }
        let image = scrollView.createScrollViewSnapshot(padding: padding)
        if #available(iOS 13, *) {
            view.insertSubview(scrollView, at: 0)
            scrollView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(buttonPanel.snp.top)
            }
        }
        return image
    }

}
