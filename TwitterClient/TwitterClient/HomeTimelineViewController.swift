//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by David Porter on 3/20/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
	var tweetLoader = [Tweet]()
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		
		JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
			if(success) {
				guard let tweets = tweets else {
					fatalError("Tweets came bck nil")
				}
				for tweet in tweets {
					tweetLoader.append(tweet)
					print(tweet.text)	
				}
			}
		}
    }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweetLoader.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let tweetToDisplay = tweetLoader[indexPath.row]
		cell.textLabel?.text = tweetToDisplay.text
		
		cell.detailTextLabel?.text = tweetToDisplay.user?.name
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
	}
	
}
    



