//
//  CenterTwitterViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

var storyboard = UIStoryboard(name:"Main",bundle:nil)
class CenterTwitterViewController: UIViewController {

    var profileViewController:ProfileViewController!
    var timeLineViewController:TimelineViewController!

    func addNavigationController(){
        menuButton = CustomMenuButton()
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parentViewController as? ContainerViewController {
                containerVC.toggleSideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }

    // MARK: ViewController
    var menuButton:CustomMenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewController = storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        timeLineViewController = storyboard?.instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
        selectViewController(0)
        addNavigationController()

    }

    func selectViewController(selectedController : Int){
        var viewController:UIViewController!
        switch selectedController{
        case 1:
            viewController = timeLineViewController
        default:
            viewController = profileViewController
        }
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
    }


}
