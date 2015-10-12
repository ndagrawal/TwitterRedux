//
//  TweetProfileCollectionViewCell.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/11/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class TweetProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!

    func setTweetProfileCollectionViewCell(tweet:Tweet){
        displayName.text = tweet.user?.name
        screenName.text = tweet.user?.screenname
        tweetText.text  = tweet.text
      //  createdAt.text = tweet.createdAtString
        profileImage.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!))
    }

}
