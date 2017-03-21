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
	var tweetLoader = [Tweet]() {
		didSet {
			self.tableView.reloadData()
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		updateTimeLine()
		
    }
	func updateTimeLine() {
		API.shared.getTweets { (tweets) in
			OperationQueue.main.addOperation {
				self.tweetLoader = tweets ?? []
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
    



