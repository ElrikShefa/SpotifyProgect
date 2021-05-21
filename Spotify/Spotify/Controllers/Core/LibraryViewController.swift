//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import UIKit

final class LibraryViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

	}
}

private extension LibraryViewController {

	func setupUI(){
		view.backgroundColor = .systemBackground
	}

}
