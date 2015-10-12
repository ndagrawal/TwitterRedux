//
//  CustomMenuButton.swift
//  TwitterRedux
//
//  Created by Nilesh on 10/10/15.
//  Copyright © 2015 CA. All rights reserved.
//

import UIKit

class CustomMenuButton: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var imageView: UIImageView!
    var tapHandler: (()->())?

    override func didMoveToSuperview() {
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView = UIImageView(image:UIImage(named:"menu"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: Selector("didTap")))
        addSubview(imageView)
    }

    func didTap() {
        if let tap = tapHandler {
            tap()
        }
    }
    

    
}
