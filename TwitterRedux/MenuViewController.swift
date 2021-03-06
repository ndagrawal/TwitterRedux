//
//  MenuViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var centerViewController : CenterTwitterViewController!
    var containterViewController: ContainerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.view.userInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillappear - MenuViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ProfileSelected(sender: AnyObject) {
        print("Profile Selected")
        containterViewController = parentViewController as! ContainerViewController
        containterViewController.toggleSideMenu()
        centerViewController.selectViewController(0)
    }

    @IBAction func onLogOut(sender: AnyObject) {
        User.currentUser?.logOut()
    }
    
    @IBOutlet weak var TimelineSelected: UIButton!

    @IBAction func TimeLineSelectedAction(sender: AnyObject) {
        print("Time Line Selected")
        containterViewController = parentViewController as! ContainerViewController
        containterViewController.toggleSideMenu()
        centerViewController.selectViewController(1)
    }


}
