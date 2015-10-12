//
//  ProfileViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationBarDelegate {



    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var profileTimeLineCollectionView: UICollectionView!



    var tweets:[Tweet]! = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = UIColor.yellowColor()
        // Do any additional setup after loading the view.

        profileImage.setImageWithURL(NSURL(string: (User.currentUser!.profileImageURL)!))
        displayName.text = User.currentUser!.name
        screenName.text = User.currentUser!.screenname
        profileTimeLineCollectionView.delegate = self
        profileTimeLineCollectionView.dataSource = self
        TwitterClient.sharedInstance.homeTimelineWithParams(nil,completion:{(tweets, error) -> () in
            self.tweets = tweets
            self.profileTimeLineCollectionView.reloadData()
        })
        setCollectionViewLayout()
        setNavigationController()
    }

    func setCollectionViewLayout(){
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSizeMake(self.view.bounds.width, 160)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        profileTimeLineCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    }

    func setNavigationController(){

      //  self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Log Out", style: UIBarButtonItemStyle.Plain, target: self, action: "onLogOut")

        //Bar Color Setup
        self.navigationItem.title = "Profile"
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.33, green:0.67, blue:0.93, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = NSDictionary.init(dictionary:
            [NSForegroundColorAttributeName:UIColor.whiteColor()]) as? [String : AnyObject]

    }




    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{

        return tweets.count
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = profileTimeLineCollectionView.dequeueReusableCellWithReuseIdentifier("TweetProfileCell", forIndexPath: indexPath) as! TweetProfileCollectionViewCell
        let tweet:Tweet = tweets[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 0.5
        cell.setTweetProfileCollectionViewCell(tweet)
        return cell
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
