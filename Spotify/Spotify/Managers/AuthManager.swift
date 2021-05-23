//
//  AuthManager.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import Foundation

final class AuthManager {

	static let shared = AuthManager()

	struct Constants {
		static let clientID = "85f5bf43433948ad992793bec814b7f4"
		static let clientSecret = "872fda6f02b8443a9681193d66d9f706"
	}

	public var signInURL: URL? {
		let scopes = "user-read-private"
		let redirectURL = "https://www.iosacademy.io"
		let base = "https://accounts.spotify.com/authorize"
		let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURL)&show_dialog=TRUE"
		return URL(string: string)
	}

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

	public func exchangeCodeForToken(code: String, comlition: @escaping (Bool) -> Void) {
		//Get token
	}

	public func refreshAccessToken() {

	}
}

private extension AuthManager {

	func cacheToken() {

	}
}
