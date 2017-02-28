//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Sandeep Raghunandhan on 2/27/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        User.currentUser = nil
        TwitterClient.sharedInstance?.logout()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = .none
        return cell 
    }

}
