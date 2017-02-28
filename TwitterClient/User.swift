//
//  User.swift
//  TwitterClient
//
//  Created by Sandeep Raghunandhan on 2/27/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        
        tagline = dictionary["description"] as? String
    }

    static var _currentUser: User?
    
    static let userDidLogoutNotification = "userDidLogout"
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: .allowFragments) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                do {
                    let userData = try JSONSerialization.data(withJSONObject: user.dictionary!, options: []) as Data
                    defaults.setValue(userData, forKey: "currentUserData")
                }
                catch let error  {
                    print(error.localizedDescription)
                }
                
            } else {
                defaults.setValue(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }

}
