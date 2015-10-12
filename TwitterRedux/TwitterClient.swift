//
//  TwitterClient.swift
//  TwitterOAuthDemo
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit


let twitterConsumerKey = "RttV1EgioEIE49s2y5EhUfjHw"
let twitterConsumerSecret = "n1aKkRq9so4o9sUUyGejsEtyoApF0l5kmUGbauzDnlwLdQFNw1"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1RequestOperationManager {


    var loginCompletion:((user:User?,error:NSError?)->())?

    class var sharedInstance : TwitterClient {
        struct  Static {
            static let instance = TwitterClient(baseURL:twitterBaseURL,consumerKey: twitterConsumerKey ,consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }



    func homeTimelineWithParams(params:NSDictionary?,completion:(tweets:[Tweet]?,error:NSError?)->()){
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            // print("home_timeline \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            print("Count of Tweets \(tweets.count)")
          completion(tweets: tweets, error: nil)
            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("Failure to get timeline")
                completion(tweets: nil, error: error)
        })
    }



    func loginWithCompletion(completion:(user:User?,error:NSError?)->()){
        loginCompletion = completion
        
        //Fetch Request Token ?& Redirect to authorization page.
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("Got the Request Token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }, failure: { (error : NSError!) -> Void in
                print("Error Occured")
                self.loginCompletion? (user:nil,error:error)
        })

    }

    func openURL(url:NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query)!, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            print("Receied Access Token ")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)

            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                
                print("user \(user.name!)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    print("Failure to verify credentials")
            })


               }
            ) { (error:NSError!) -> Void in
                print(" Failed to receive access token")
        }

}



}
