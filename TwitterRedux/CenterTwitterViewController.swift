//
//  CenterTwitterViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class CenterTwitterViewController: UIViewController {

    //View Controller Arrays ...
    var viewControllers:[UIViewController]=[
        ProfileViewController.init(nibName:nil,bundle:nil),
        TimelineViewController.init(nibName: nil, bundle: nil)
    ]

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
        selectViewController(0)
        addNavigationController()
    }

    func selectViewController(selectedController : Int){
        let viewController:UIViewController = viewControllers[selectedController]
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
    }


}
