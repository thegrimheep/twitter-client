//
//  Tweet.swift
//  TwitterClient
//
//  Created by David Porter on 3/20/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

import Foundation


class Tweet {
	let text: String
	let id: String
	let retweets : Int
	
	var user: User?
	init?(json: [String: Any]) {
		if let text = json["text"] as? String, let id = json["id_str"] as? String, let retweets = json["retweet_count"] as? Int {
			self.retweets = retweets
			self.text = text
			self.id = id
			if let userDictionary = json["user"] as? [String: Any] {
				self.user = User(json: userDictionary)
			}
		}
		else {
			return nil
		}
	}
}
