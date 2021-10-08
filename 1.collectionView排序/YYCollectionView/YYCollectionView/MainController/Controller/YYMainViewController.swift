//
//  YYMainViewController.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/9/23.
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
        self.view.addSubview(self.systemButton)
        self.view.addSubview(self.customRealCellButton)
        self.view.addSubview(self.customImageButton)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.systemButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view).offset(-110)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        self.customRealCellButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        self.customImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view).offset(110)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击系统方法
    @objc func clickSystemButton() -> () {
        let systemViewCtrl = YYSystemViewController()
        systemViewCtrl.modalPresentationStyle = .fullScreen
        self.present(systemViewCtrl, animated: true) {
            
        }
    }
    
    //MARK:移动真实Cell
    @objc func clickRealCellButton() -> () {
        let customViewCtrl = YYCustomRealCellController()
        customViewCtrl.modalPresentationStyle = .fullScreen
        self.present(customViewCtrl, animated: true) {
            
        }
    }
    
    //MARK:移动Image
    @objc func clickImageButton() -> () {
        let customViewCtrl = YYCustomImageController()
        customViewCtrl.modalPresentationStyle = .fullScreen
        self.present(customViewCtrl, animated: true) {
            
        }
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:系统方法排序按钮
    lazy var systemButton: UIButton = {
        let button = UIButton()
        button.setTitle("系统方法", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickSystemButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:自定义排序(移动Cell)
    lazy var customRealCellButton: UIButton = {
        let button = UIButton()
        button.setTitle("真实Cell", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickRealCellButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:自定义排序(移动Image)
    lazy var customImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Image", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickImageButton), for: .touchUpInside)
        return button
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

