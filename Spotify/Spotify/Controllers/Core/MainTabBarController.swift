//
//  MainTabBarController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

	}
}

private extension MainTabBarController {

	func setupUI(){

		let vc1 = HomeViewController()
		let vc2 = SearchViewController()
		let vc3 = LibraryViewController()

		setViewControllers([makeNavController(title: "Home", view: vc1, tabTitle: "Home", tabImage: "house"),
							makeNavController(title: "Search", view: vc2, tabTitle: "Search", tabImage: "magnifyingglass"),
							makeNavController(title: "Library", view: vc3, tabTitle: "Library", tabImage: "music.note.list")],
						   animated: false)
	}

	func makeNavController(title: String, view: UIViewController, tabTitle: String? = nil, tabImage: String) -> UINavigationController {
		view.title = title
		view.navigationItem.largeTitleDisplayMode = .always

		let nav = UINavigationController(rootViewController: view)
		nav.tabBarItem = UITabBarItem(title: tabTitle, image: UIImage(systemName: tabImage), tag: 1)
		nav.navigationBar.prefersLargeTitles = true

		return nav
	}
}
