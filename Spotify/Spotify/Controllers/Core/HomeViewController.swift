//
//  HomeViewController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import UIKit

final class HomeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

	}
}

private extension HomeViewController {

	func setupUI(){
		view.backgroundColor = .systemBackground
	}

}
