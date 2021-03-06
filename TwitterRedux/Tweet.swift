//
//  Tweet.swift
//  TwitterOAuthDemo
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAtString : String?
    var createdAt: NSDate?

    init(dictionary:NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:MM:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }

    class func tweetsWithArray(array:[NSDictionary])->[Tweet]{
        var tweets = [Tweet]()
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }

}
