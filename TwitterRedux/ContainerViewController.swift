//
//  ContainerViewController.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    let menuWidth: CGFloat = 100.0
    let animationTime: NSTimeInterval = 0.5

    let menuViewController: UIViewController!
    let centerViewController: UIViewController!

    var isOpening = false
    //Different View Controllers

    init(sideMenu: UIViewController, center: UIViewController) {
        menuViewController = sideMenu
        centerViewController = center
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        menuViewController = UIViewController.init(coder:aDecoder)
        centerViewController = UIViewController.init(coder:aDecoder)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()

        addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.didMoveToParentViewController(self)

        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)

        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0,
            width: menuWidth, height: view.frame.height)

        let panGesture = UIPanGestureRecognizer(target:self, action:Selector("handleGesture:"))
        view.addGestureRecognizer(panGesture)
        //self.selectViewController(0)
    }

    func handleGesture(recognizer:UIPanGestureRecognizer) {

        let translation = recognizer.translationInView(recognizer.view!.superview!)

        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)

        switch recognizer.state {
        case .Began:
            let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
            isOpening = isOpen == 1.0 ? false: true

        case .Changed:
            let progessPercent = (isOpening ? progress: (1.0 - progress))
            self.centerViewController.view.frame.origin.x = menuWidth * CGFloat(progessPercent)
            self.menuViewController.view.frame.origin.x = menuWidth * CGFloat(progessPercent) - menuWidth

        case .Ended:
            print("Ended")
        case .Cancelled:
            print("Cancelled")
        case .Failed:
            var targetProgress: CGFloat
            if (isOpening) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            UIView.animateWithDuration(animationTime, animations: {
                self.centerViewController.view.frame.origin.x = self.menuWidth * CGFloat(targetProgress)
                self.menuViewController.view.frame.origin.x = self.menuWidth * CGFloat(targetProgress) - self.menuWidth

                }, completion: { _ in
                    //
            })

        default: break
        }
    }

    func toggleSideMenu() {
        let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0

        UIView.animateWithDuration(animationTime, animations: {
            self.centerViewController.view.frame.origin.x = self.menuWidth * CGFloat(targetProgress)
            self.menuViewController.view.frame.origin.x = self.menuWidth * CGFloat(targetProgress) - self.menuWidth
            }, completion: { _ in
                self.menuViewController.view.layer.shouldRasterize = false
        })
    }
}


















