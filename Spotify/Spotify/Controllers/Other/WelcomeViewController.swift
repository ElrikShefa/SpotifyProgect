//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 21.05.2021.
//

import UIKit

final class WelcomeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
}

private extension WelcomeViewController {

	func setupUI() {
		title = "Spotify"
		view.backgroundColor = .green
	}
}

