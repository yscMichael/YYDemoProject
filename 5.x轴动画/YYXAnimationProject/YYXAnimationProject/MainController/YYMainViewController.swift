//
//  YYMainViewController.swift
//  YYXAnimationProject
//
//  Created by 杨世川 on 2021/9/29.
//

import UIKit

//MARK:- 常量 -
let YYButtonHeight = 66
let YYButtonWidth = 360

class YYMainViewController: UIViewController {
    //MARK: - 属性 -
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.view.addSubview(self.testButton)
        self.testButton.addSubview(self.testImageView)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.testButton.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.width.equalTo(360)
            make.height.equalTo(66)
        }
        self.testImageView.frame = CGRect(x: 0, y: 0, width: 0, height: YYButtonHeight)
        self.testImageView.center = CGPoint(x: YYButtonWidth/2, y: YYButtonHeight/2)
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击测试动画按钮
    @objc func clickTestAnimation() -> () {
        self.testImageView.isHidden = false
        self.testImageView.frame = CGRect(x: 0, y: 0, width: 0, height: YYButtonHeight)
        self.testImageView.center = CGPoint(x: YYButtonWidth/2, y: YYButtonHeight/2)
        UIView.animate(withDuration: 1.0) {
            self.testImageView.frame = CGRect(x: 0, y: 0, width: 360, height: 65)
            self.testImageView.center = CGPoint(x: YYButtonWidth/2, y: YYButtonHeight/2)
        }
    }
    
    //MARK:结束动画
    @objc func endAnimation() -> () {
        self.testImageView.isHidden = true
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:测试按钮
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("按下有动画", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickTestAnimation), for: .touchDown)
        button.addTarget(self, action: #selector(endAnimation), for: .touchUpInside)
        return button
    }()
    
    //MARK:testImageView
    lazy var testImageView: UIImageView = {
        let testImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        testImageView.image = UIImage(named: "btn_bg_pes02")
        testImageView.isHidden = false
        return testImageView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
