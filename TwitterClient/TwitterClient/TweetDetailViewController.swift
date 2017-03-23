//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by David Porter on 3/22/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
	
	var tweet : Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tweetDis.text = tweet.text
		self.tweetUser.text = tweet.user?.name
		self.retweetedNum.text = ("Retweets: \(self.tweet.retweets)")
		//Lab work here
		//print(self.tweet.user?.name ?? "Unknown")
		//print(self.tweet.text)

		
    }


	@IBOutlet weak var tweetDis: UILabel!
	@IBOutlet weak var tweetUser: UILabel!
	@IBOutlet weak var retweetedNum: UILabel!
}
