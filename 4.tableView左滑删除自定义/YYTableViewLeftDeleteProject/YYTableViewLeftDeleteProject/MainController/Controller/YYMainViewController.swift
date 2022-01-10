//
//  YYMainViewController.swift
//  YYTableViewLeftDeleteProject
//
//  Created by 杨世川 on 2021/9/24.
//

import UIKit

let SPCScreenWidth = UIScreen.main.bounds.size.width
let SPCScreenHeight = UIScreen.main.bounds.size.height
let SPCButtonHeight = 50

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
        self.title = "tableView侧滑按钮"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(self.editingStyleButton)
        self.view.addSubview(self.editActionsButton)
        self.view.addSubview(self.trailingSwipeButton)
        
        self.view.addSubview(self.gestureButton)
        self.view.addSubview(self.subViewButton)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.editingStyleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(SPCButtonHeight)
        }
        self.editActionsButton.snp.makeConstraints { make in
            make.top.equalTo(self.editingStyleButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(SPCButtonHeight)
        }
        self.trailingSwipeButton.snp.makeConstraints { make in
            make.top.equalTo(self.editActionsButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(SPCButtonHeight)
        }
        
        self.gestureButton.snp.makeConstraints { make in
            make.top.equalTo(self.trailingSwipeButton.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(SPCButtonHeight)
        }
        self.subViewButton.snp.makeConstraints { make in
            make.top.equalTo(self.gestureButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(SPCButtonHeight)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击按钮
    @objc func clickButton(_ sender: UIButton) -> () {
        switch sender.tag {
        case 1001://editingStyle按钮
            let systemEditingStyleCtrl = YYSystemEditingStyleController()
            self.navigationController?.pushViewController(systemEditingStyleCtrl, animated: true)
            break
        case 1002://editActions按钮
            let systemEditActionsCtrl = YYSystemEditActionsController()
            self.navigationController?.pushViewController(systemEditActionsCtrl, animated: true)
            break
        case 1003://trailingSwipe按钮
            let trailingSwipeCtrl = YYTrailingSwipeController()
            self.navigationController?.pushViewController(trailingSwipeCtrl, animated: true)
            break
            
        case 1004://添加滑动手势按钮
            let addGestureViewCtrl = YYAddGestureViewController()
            self.navigationController?.pushViewController(addGestureViewCtrl, animated: true)
            break
        case 1005://找到子View添加按钮
            let subViewButtonCtrl = YYSubViewButtonController()
            self.navigationController?.pushViewController(subViewButtonCtrl, animated: true)
            break
        default:
            break
        }
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:- 系统方法 -
    //MARK:editingStyle按钮
    lazy var editingStyleButton: UIButton = {
        let button = UIButton()
        button.setTitle("editingStyle按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 1001
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK:editActions按钮
    lazy var editActionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("editActions按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 1002
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK:trailingSwipe按钮
    lazy var trailingSwipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("trailingSwipe按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 1003
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK:- 自定义方法 -
    //MARK:添加滑动手势按钮
    lazy var gestureButton: UIButton = {
        let button = UIButton()
        button.setTitle("添加滑动手势按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 1004
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK:找到子View添加按钮
    lazy var subViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("找到子View添加按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 1005
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

