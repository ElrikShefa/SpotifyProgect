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
		static let tokenAPIURL = "https://accounts.spotify.com/api/token"
		static let redirectURL = "https://www.iosacademy.io"
		static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
	}

	public var signInURL: URL? {
		let base = "https://accounts.spotify.com/authorize"
		let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
		return URL(string: string)
	}

	private init() {}

	var isSignedIn: Bool {
		return accessToken != nil
	}

	private var accessToken: String? {
		return UserDefaults.standard.string(forKey: "access_token")
	}

	private var refreshToken: String? {
		return UserDefaults.standard.string(forKey: "refresh_token")
	}

	private var tokenExpiretionDate: Date? {
		return UserDefaults.standard.object(forKey: "expirationDate") as? Date
	}

	private var shouldRefreshToken: Bool {
		guard let expirationDate = tokenExpiretionDate else { return false }
		let currentDate = Date()
		let fiveMinutes: TimeInterval = 300
		return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
	}

	public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: Constants.tokenAPIURL) else { return }
		//Get token
		var components = URLComponents()
		components.queryItems = [
			URLQueryItem(name: "grant_type", value: "authorization_code"),
			URLQueryItem(name: "code", value: code),
			URLQueryItem(name: "redirect_uri", value: Constants.redirectURL)
		]

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.httpBody = components.query?.data(using: .utf8)

		let basicToken = Constants.clientID + ":" + Constants.clientSecret
		let data = basicToken.data(using: .utf8)
		guard let base64String = data?.base64EncodedString() else {
			assertionFailure("Failure to get base64")
			completion(false)
			return
		}

		request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

		let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			guard
				let data = data, let self = self, error == nil else {
				completion(false)
				return
			}

			do {
				//				let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
				let result = try JSONDecoder().decode(AuthResponse.self, from: data)
				self.cacheToken(result: result)
				//				print("SUCCESS: \(json)")
			}
			catch {
				print(error.localizedDescription)
				completion(true)
			}
		}
		task.resume()
	}

	public func withValidToken(completion: @escaping (String) -> Void) {
		if shouldRefreshToken {
			//refresh
			refreshIfNeeded { [weak self] success in
				guard let self = self else { return }

				if let token = self.accessToken, success {
					completion(token)

				}
			}
		}
		else if let token = accessToken {
			completion(token)
		}
	}

	public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
		guard shouldRefreshToken else {
			completion(true)
			return
		}
		guard let refreshToken = self.refreshToken else { return }
		//refresh the token
		guard let url = URL(string: Constants.tokenAPIURL) else { return }
		//Get token
		var components = URLComponents()
		components.queryItems = [
			URLQueryItem(name: "grant_type", value: "refresh_token"),
			URLQueryItem(name: "refresh_token", value: refreshToken)
		]

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.httpBody = components.query?.data(using: .utf8)

		let basicToken = Constants.clientID + ":" + Constants.clientSecret
		let data = basicToken.data(using: .utf8)
		guard let base64String = data?.base64EncodedString() else {
			assertionFailure("Failure to get base64")
			completion(false)
			return
		}

		request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

		let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			guard
				let data = data, let self = self, error == nil else {
				completion(false)
				return
			}

			do {
				let result = try JSONDecoder().decode(AuthResponse.self, from: data)
				print("Successfully refreshed")
				self.cacheToken(result: result)
			}
			catch {
				print(error.localizedDescription)
				completion(true)
			}
		}
		task.resume()

	}
}

private extension AuthManager {

	func cacheToken(result: AuthResponse) {
		UserDefaults.standard.setValue(result.access_token, forKey: "access_token")

		if let refresh_token = result.refresh_token {
			UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
		}

		UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
	}
}

