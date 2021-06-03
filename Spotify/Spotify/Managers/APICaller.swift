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
