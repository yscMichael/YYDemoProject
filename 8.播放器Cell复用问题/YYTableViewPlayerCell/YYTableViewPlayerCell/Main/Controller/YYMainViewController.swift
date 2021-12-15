//
//  YYMainViewController.swift
//  YYTableViewPlayerCell
//
//  Created by 杨世川 on 2021/12/13.
//

import UIKit
//MARK:- 常量 -
/// 屏幕的宽
let ScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高
let ScreenHeight = UIScreen.main.bounds.size.height
/// 导航栏高度:通用
let NavgationBarHeight = UINavigationController().navigationBar.frame.size.height

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
        self.title = "主控制器"
        self.view.addSubview(self.singleButton)
        self.view.addSubview(self.singleOtherButton)
        self.view.addSubview(self.manyButton)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.singleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        self.singleOtherButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.singleButton.snp.centerX)
            make.top.equalTo(self.singleButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        self.manyButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.singleOtherButton.snp.centerX)
            make.top.equalTo(self.singleOtherButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击单个播放器按钮(不连续)
    @objc func clickSingleButton(_ sender: UIButton) -> () {
        let singleCellReuseCtrl = YYSingleCellReuseController()
        self.navigationController?.pushViewController(singleCellReuseCtrl, animated: true)
    }
    
    //MARK:点击单个播放器按钮(连续)
    @objc func clickSingleOtherButton(_ sender: UIButton) -> () {
        let singleOtherCellReuseCtrl = YYSingleOtherCellReuseController()
        self.navigationController?.pushViewController(singleOtherCellReuseCtrl, animated: true)
    }
    
    //MARK:点击多个播放器按钮
    @objc func clickManyButton(_ sender: UIButton) -> () {
        let manyCellReuseCtrl = YYManyCellReuseController()
        self.navigationController?.pushViewController(manyCellReuseCtrl, animated: true)
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:单个播放器
    lazy var singleButton: UIButton = {
        let singleButton = UIButton.init(frame: CGRect.zero)
        singleButton.setTitle("单个播放器(不连续)", for: .normal)
        singleButton.backgroundColor = UIColor.blue
        singleButton.titleLabel?.textColor = UIColor.white
        singleButton.addTarget(self, action: #selector(clickSingleButton(_:)), for: .touchUpInside)
        return singleButton
    }()
    
    //MARK:单个播放器other
    lazy var singleOtherButton: UIButton = {
        let singleButton = UIButton.init(frame: CGRect.zero)
        singleButton.setTitle("单个播放器(连续)", for: .normal)
        singleButton.backgroundColor = UIColor.blue
        singleButton.titleLabel?.textColor = UIColor.white
        singleButton.addTarget(self, action: #selector(clickSingleOtherButton(_:)), for: .touchUpInside)
        return singleButton
    }()
    
    //MARK:多个播放器
    lazy var manyButton: UIButton = {
        let manyButton = UIButton.init(frame: CGRect.zero)
        manyButton.setTitle("多个播放器", for: .normal)
        manyButton.backgroundColor = UIColor.blue
        manyButton.titleLabel?.textColor = UIColor.white
        manyButton.addTarget(self, action: #selector(clickManyButton(_:)), for: .touchUpInside)
        return manyButton
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
