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
		
		//Lab work here
		print(self.tweet.user?.name ?? "Unknown")
		print(self.tweet.text)

		
    }



}
