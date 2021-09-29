//
//  SPCHomeListTableViewCell.swift
//  SkyPiCameraiOSProject
//
//  Created by 杨世川 on 10/25/19.
//  Copyright © 2020 skyworth. All rights reserved.
//

import UIKit

class SPCHomeListTableViewCell: UITableViewCell {
    //容器View
    @IBOutlet weak var containerView: UIView!
    //左侧View
    @IBOutlet weak var leftView: UIView!
    
    //MARK:Cycle Life
    override func awakeFromNib() {
        super.awakeFromNib()
        //左侧轻扫
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.leftView.addGestureRecognizer(leftSwipe)
        //右侧轻扫
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.leftView.addGestureRecognizer(rightSwipe)
    }
    
    //MARK:Event Response
    //MARK:轻扫手势
    @objc func swipe(swipe: UISwipeGestureRecognizer) -> () {
        let leftView = swipe.view!
        //左滑
        if swipe.direction == UISwipeGestureRecognizer.Direction.left {
            print("swipe======P")
            print(leftView.frame)
            if leftView.frame.origin.x == 0 {
                UIView.animate(withDuration: 0.2) {
                    var originFrame = leftView.frame
                    originFrame.origin.x = originFrame.origin.x - 80
                    leftView.frame = originFrame
                }
            }
        }
        //右滑
        if swipe.direction == UISwipeGestureRecognizer.Direction.right {
            if leftView.frame.origin.x == -80 {
                UIView.animate(withDuration: 0.2) {
                    var originFrame = leftView.frame
                    originFrame.origin.x = originFrame.origin.x + 80
                    leftView.frame = originFrame
                }
            }
        }
    }
}
