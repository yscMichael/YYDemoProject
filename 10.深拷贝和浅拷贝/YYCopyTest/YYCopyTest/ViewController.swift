//
//  ViewController.swift
//  YYCopyTest
//
//  Created by 杨世川 on 2022/1/12.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - 属性 -
    var model = YYTestModel()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.view.addSubview(self.testView)
        self.view.addSubview(self.testButton)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.testView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.testButton.snp.makeConstraints { make in
            make.top.equalTo(self.testView.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        self.model.testInt = 100
        self.model.testString = "100"
        self.testView.setModel(model: self.model)
    }
    
    //MARK: - Event Response -
    //MARK:点击方法
    @objc func clickButton() -> () {
        self.model.testInt = 1000
        self.model.testString = "1000"
        self.testView.printModel()
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:YYTestView
    lazy var testView: YYTestView = {
        let testView = YYTestView.init(frame: CGRect.zero)
        return testView
    }()
    
    //MARK:button
    lazy var testButton: UIButton = {
        let testButton = UIButton.init(frame: CGRect.zero)
        testButton.setTitle("测试按钮", for: .normal)
        testButton.backgroundColor = UIColor.blue
        testButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return testButton
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

