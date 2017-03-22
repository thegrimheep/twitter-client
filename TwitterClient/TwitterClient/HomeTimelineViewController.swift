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
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var tweetLoader = [Tweet]() {
		didSet {
			self.tableView.reloadData()
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.title = "My Timeline"
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.estimatedRowHeight = 50
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		updateTimeLine()
		
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		if segue.identifier == "showDetailSegue" {
			if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
			let selectedTweet = self.tweetLoader[selectedIndex]
			
			guard let destinationController = segue.destination as? TweetDetailViewController else {
				return
			}
				destinationController.tweet = selectedTweet
			}
		}
	}
	
	func updateTimeLine() {
		self.activityIndicator.startAnimating()
		API.shared.getTweets { (tweets) in
			OperationQueue.main.addOperation {
				self.tweetLoader = tweets ?? []
				self.activityIndicator.stopAnimating()
			}
		}
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweetLoader.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TweetCell
		cell.tweetText.text = tweetLoader[indexPath.row].text
		return cell
	}
	//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	//	print(indexPath.row)
	//}
	
}
    



