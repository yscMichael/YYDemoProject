//
//  YYMainViewController.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/9/24.
//

import UIKit

//MARK:- 常量 -
//MARK:屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//MARK:屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

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
        self.view.addSubview(self.testTitleButton)
        self.view.addSubview(self.systemFlowButton)
        self.view.addSubview(self.customFlowButtonOne)
        self.view.addSubview(self.customFlowButtonTwo)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.testTitleButton.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(200)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        self.systemFlowButton.snp.makeConstraints { make in
            make.top.equalTo(self.testTitleButton.snp.bottom).offset(20)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        self.customFlowButtonOne.snp.makeConstraints { make in
            make.top.equalTo(self.systemFlowButton.snp.bottom).offset(20)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        self.customFlowButtonTwo.snp.makeConstraints { make in
            make.top.equalTo(self.customFlowButtonOne.snp.bottom).offset(20)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击测试文本按钮
    @objc func clickTestLabelButton() -> () {
        print("clickTestLabelButton==========P")
        let labelSizeCtrl = YYLabelSizeController()
        self.navigationController?.pushViewController(labelSizeCtrl, animated: true)
    }
    
    //MARK:点击系统FlowLayout按钮
    @objc func clickSystemMethod() -> () {
        print("clickSystemMethod==========P")
        let systemFlowLayoutCtrl = YYSystemFlowLayoutController()
        self.navigationController?.pushViewController(systemFlowLayoutCtrl, animated: true)
    }
    
    //MARK:点击自定义FlowLayout-1
    @objc func clickCustomMethodOne() -> () {
        print("clickCustomMethodOne==========P")
        let customFlowLayoutCtrl = YYCustomFlowLayoutOneController()
        self.navigationController?.pushViewController(customFlowLayoutCtrl, animated: true)
    }
    
    //MARK:点击自定义FlowLayout-2
    @objc func clickCustomMethodTwo() -> () {
        print("clickCustomMethodTwo==========P")
        let customFlowLayoutCtrl = YYCustomFlowLayoutTwoController()
        self.navigationController?.pushViewController(customFlowLayoutCtrl, animated: true)
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:测试文本按钮
    lazy var testTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("测试文本", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickTestLabelButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:系统FlowLayout方法
    lazy var systemFlowButton: UIButton = {
        let button = UIButton()
        button.setTitle("系统Flow", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickSystemMethod), for: .touchUpInside)
        return button
    }()
    
    //MARK:自定义FlowLayout方法-1
    lazy var customFlowButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("自定义Flow1", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickCustomMethodOne), for: .touchUpInside)
        return button
    }()
    
    //MARK:自定义FlowLayout方法-2
    lazy var customFlowButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("自定义Flow2", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickCustomMethodTwo), for: .touchUpInside)
        return button
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

