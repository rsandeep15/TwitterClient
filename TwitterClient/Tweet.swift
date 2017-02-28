//
//  Tweet.swift
//  TwitterClient
//
//  Created by Sandeep Raghunandhan on 2/27/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favorites_count: Int = 0;
    var user: NSDictionary?
    var username: String?
    var profileUrl: URL?
    var id: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        user = dictionary["user"] as? NSDictionary!
        username = user!["name"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favorites_count = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
            
        }
        
        profileUrl = URL(string: (user!["profile_image_url_https"] as? String)!)
        id = dictionary["id_str"] as? String
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
