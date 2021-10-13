//
//  YYMainViewController.swift
//  YYGestureProject
//
//  Created by 杨世川 on 2021/9/24.
//

import UIKit

let YYScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let YYScreenHeight: CGFloat = UIScreen.main.bounds.size.height

class YYMainViewController: UIViewController {
    //MARK: - 属性 -
    var imageView: UIImageView = UIImageView.init()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    //MARK:初始化Views
    //tap、pan、swipe、longPress、rotation、pinch
    //参考资料:https://www.jianshu.com/p/b887af45d5de
    func initViews() -> () {
        self.imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.center = CGPoint(x: YYScreenWidth/2.0, y: YYScreenHeight/2.0)
        self.imageView.image = UIImage(named: "index_ad01_en")
        self.view.addSubview(self.imageView)
        //这里对轻扫手势进行验证
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(swipe:)))
        swipe.direction = UISwipeGestureRecognizer.Direction.left
        self.imageView.addGestureRecognizer(swipe)
    }
    
    //MARK: - Event Response -
    //MARK:轻扫手势
    @objc func swipe(swipe: UISwipeGestureRecognizer) -> () {
        let imageView = swipe.view as! UIImageView
        if swipe.direction == UISwipeGestureRecognizer.Direction.left {
            print("swipe======P")
            UIView.animate(withDuration: 0.5) {
                var originFrame = imageView.frame
                originFrame.origin.x = originFrame.origin.x - 50
                imageView.frame = originFrame
            }
        }
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
