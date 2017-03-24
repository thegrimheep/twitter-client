//
//  API.swift
//  TwitterClient
//
//  Created by David Porter on 3/21/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

import Social
import Accounts
import Foundation

typealias UserCallback = (User?) -> ()
typealias TweetsCallback = ([Tweet]?) -> ()
typealias AccountCallback = (ACAccount?) -> ()  //for multiple account this will return an optional [AXAccounts] of accounts

class API {
	static let shared = API()
	var account : ACAccount?
	
	private func login(callback: @escaping AccountCallback) {
		let accountStore = ACAccountStore()
		let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
		
		accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error)
			in
			if let error = error {
				print ("Error: \(error.localizedDescription)")
				callback(nil)
				return
			}
			if success {
				if let account = accountStore.accounts(with: accountType).first as? ACAccount {
					callback(account)
				}//this where you have access to multiple twiiter accounts
			}
			else {
				print("The user did not allow access")
				callback(nil)
			}
		}
	}
	
	private func getOAuthUser(callback: @escaping UserCallback) {
		let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
		if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
			request.account = self.account
			request.perform(handler: { (data, response, error) in
				if let error = error {
					print("Error: \(error)")
					callback(nil)
					return
				}
				guard let response = response else {
					callback(nil)
					return
				}
				guard let data = data else {
					callback(nil)
					return
				}
				switch response.statusCode {
				case 200...299:
					JSONParser.userReturn(data: data, callback: { (success, user) in
						callback(user)
					})
					
				case 400...499:
					print("Error: Client Error")
					
				case 500...599:
					print("Error: Server error")
					
				default:
					callback(nil)
				}
			})
		}
		
	}
	
	private func updateTimeLine(url: String, callback: @escaping TweetsCallback) {
		//let url = URL(string: "")
		if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: URL(string: url), parameters: nil) {
			request.account = self.account
			request.perform(handler: { (data, response, error) in
				if let error = error {
					print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
					callback(nil)
					return
				}
				guard let response = response else {
					callback(nil)
					return
				}
				guard let data = data else {
					callback(nil)
					return
				}
				if response.statusCode >= 200 && response.statusCode < 300 {
					JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
						if success {
							callback(tweets)
						}
					})
				}
				else {
					print("Something went wrong")
					callback(nil)
				}
			})
		}
		
	}
	
	func getTweets(callback: @escaping TweetsCallback) {
		if self.account == nil {
			login(callback: { (account) in
				if let account = account {
					self.account = account
					self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in callback(tweets)
					})
				}
			})
		}
		else {
			self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in callback(tweets)
			})
		}
	}
	func getTweetsFor(_ user: String, callback: @escaping TweetsCallback) {
		let urlString = "https://api.twitter.com/1.1/statues/user_timeline.json?screen_name=\(user)"
		
		self.updateTimeLine(url: urlString) { (tweets) in
			callback(tweets)
		}
	}
}
