//
//  User.swift
//  TwitterClient
//
//  Created by David Porter on 3/20/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

import Foundation


class User {
	let name: String
	let profileImageURL: String
	let location: String
	
	init?(json: [String: Any]) {
		if let name = json["name"] as? String,
			let profileImageURL = json["profile_image_url"] as? String,
			let location = json["location"] as? String {
			self.name = name
			self.profileImageURL = profileImageURL
			self.location = location
		}
		else {
			return nil
		}
	}
}
