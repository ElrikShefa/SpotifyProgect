//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 21.05.2021.
//

import UIKit

final class WelcomeViewController: UIViewController {

	private lazy var singInButton = UIButton(type: .system)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
}

private extension WelcomeViewController {
	
	func setupUI() {
		title = "Spotify"
		view.backgroundColor = .green

		singInButton.backgroundColor = .white
		singInButton.setTitle("Sing In with Spotify", for: .normal)
		singInButton.setTitleColor(.blue, for: .normal)
		singInButton.addTarget(self, action: #selector(didTapSingIn), for: .touchUpInside)
		singInButton.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(singInButton)

		NSLayoutConstraint.activate([
			singInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			singInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			singInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
			singInButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc func didTapSingIn() {
		let vc = AuthViewController()
		vc.navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(vc, animated: true)
	}

	func handleSignIn(success: Bool) {
		//log user in or yell at them for error
		guard success else {
			let alert = UIAlertController(title: "Ooops",
										  message: "Something went wrong when singin in",
										  preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
			present(alert, animated: true)
			return
		}

		let mainAppTabBarVC = MainTabBarController()
		mainAppTabBarVC.modalPresentationStyle = .fullScreen
		present(mainAppTabBarVC, animated: true)

	}
}

