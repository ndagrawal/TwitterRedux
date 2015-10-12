//
//  TimelineViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var tweets:[Tweet]! = [Tweet]()
    @IBOutlet weak var timeLineCollectionView: UICollectionView!
    var menuButton: CustomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineCollectionView.delegate = self
        timeLineCollectionView.dataSource = self

        TwitterClient.sharedInstance.homeTimelineWithParams(nil,completion:{(tweets, error) -> () in
            self.tweets = tweets
            self.timeLineCollectionView.reloadData()
        })
        setNavigationController()
        setCollectionViewLayout()
    }

    func setCollectionViewLayout(){
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSizeMake(self.view.bounds.width, 160)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        timeLineCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    }


    func setNavigationController(){
        //Bar Color Setup
        self.navigationItem.title = "TimeLine"
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.33, green:0.67, blue:0.93, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = NSDictionary.init(dictionary:
            [NSForegroundColorAttributeName:UIColor.whiteColor()]) as? [String : AnyObject]
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return tweets.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = timeLineCollectionView.dequeueReusableCellWithReuseIdentifier("TweetTimelineCell", forIndexPath: indexPath) as! TweetTimeLineCollectionViewCell
        let tweet:Tweet = tweets[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 0.5
        cell.setTweetTimeCollectionViewCell(tweet)
        return cell
    }


}
