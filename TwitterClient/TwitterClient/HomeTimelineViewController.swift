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
		
		let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
		
		self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
		
		self.navigationItem.title = "My Timeline"
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.estimatedRowHeight = 75
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		updateTimeLine()
		
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		if segue.identifier == TweetDetailViewController.identifier {
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
		let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
		let tweet = self.tweetLoader[indexPath.row]
		cell.tweet = tweet
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
	}
	
	
}
    



