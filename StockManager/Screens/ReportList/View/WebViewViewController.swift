//
//  WebViewViewController.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 3/8/2565 BE.
//

import UIKit
import WebKit

final class WebViewViewController: BaseViewController {

    static func openWebsite(url: String, using viewController: UIViewController) {
        guard let url = URL(string: url) else { return }
        let webViewController = WebViewViewController()
        viewController.navigationController?.pushViewController(webViewController, animated: true)
        webViewController.webView.load(URLRequest(url: url))
    }

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        localizeItems()
    }

    private func initUIComponents() {
        navigationController?.navigationBar.isHidden = false
        showBackButton()
        view.backgroundColor = UIColor.mainBgColor
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    override func localizeItems() {
        self.title = Localization.ReportList.pageTitle
    }

}
