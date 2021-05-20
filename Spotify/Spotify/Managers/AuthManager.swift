//
//  AuthManager.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import Foundation

final class AuthManager {

	static let shared = AuthManager()

	private init() {}

	var isSignedIn: Bool {
		return false
	}

	private var accessToken: String? {
		return nil
	}

	private var refreshToken: String? {
		return nil
	}

	private var tokenExpiretionDate: String? {
		return nil
	}

	private var shouldRefreshToken: Bool {
		return false
	}
}
