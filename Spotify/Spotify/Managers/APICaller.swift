//
//  APICaller.swift
//  Spotify
//
//  Created by Матвей Чернышев on 20.05.2021.
//

import Foundation

final class APICaller {
	
	static let shared = APICaller()
	
	private init() {}
	
	public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
		
	}
	
}

private extension APICaller {
	
	enum HTTPMethod: String {
		case GET
		case POST
	}
	
	func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
		AuthManager.shared.withValidToken { token in
			guard let apiURL = url else { return }
			var requst  = URLRequest(url: apiURL)
			requst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
			requst.httpMethod = type.rawValue
			requst.timeoutInterval = 30
			completion(requst)
		}
	}
	
}
