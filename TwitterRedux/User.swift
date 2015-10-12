//
//  User.swift
//  TwitterOAuthDemo
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

var _currentUser:User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidloginNotification"
let userDidLogOutNotification = "userDidLogoutNotification"
class User: NSObject {


    var name:String?
    var screenname:String?
    var profileImageURL:String?
    var tagline:String?
    var dictionary: NSDictionary

    init(dictionary:NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }

    func logOut(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogOutNotification, object: nil)

        }

    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do{
                let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                _currentUser = User(dictionary: dictionary!)
                    }catch{

            }
            }
        }

            return _currentUser
        }
        set(user){
            _currentUser = currentUser
            if(user != nil){
                do{
                     let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options:NSJSONWritingOptions.PrettyPrinted)
                     NSUserDefaults.standardUserDefaults().setObject(data, forKey:currentUserKey)
                     NSUserDefaults.standardUserDefaults().synchronize()
                } catch{
                    print("Error Occcured")
                }
            }else{
                
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }

    }
}