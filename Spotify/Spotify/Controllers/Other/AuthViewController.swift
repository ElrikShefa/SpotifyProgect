//
//  AuthViewController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 21.05.2021.
//

import UIKit
import WebKit

final class AuthViewController: UIViewController {

	private let webView: WKWebView = {
		let prefs = WKWebpagePreferences()
		prefs.allowsContentJavaScript = true
		let config = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: config)

		return webView
	}()

	public var completionHandler: ((Bool) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		webViewLoad()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		webView.frame = view.bounds
	}

	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		guard
			let url = webView.url,
			//Exchange the code for access token
			let code = URLComponents(string: url.absoluteString)?
				.queryItems?
				.first(where: { $0.name == "code" })?
				.value else { return}

		print("\(code)")
	}
}

extension AuthViewController: WKNavigationDelegate {}

private extension AuthViewController {

	func setupUI() {
		title = "Sing In"

		view.backgroundColor = .systemBackground
		view.addSubview(webView)

		webView.navigationDelegate = self
	}

	func webViewLoad() {
		guard let url = AuthManager.shared.signInURL else { return }
		webView.load(URLRequest(url: url))
	}
}
