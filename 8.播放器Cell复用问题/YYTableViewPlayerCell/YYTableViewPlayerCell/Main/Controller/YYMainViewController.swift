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
///定时器全局变量
var SPCGlobalTimeCount = -1

class YYMainViewController: UIViewController {
    //MARK: - 属性 -
    ///可见cell(方案一)
    var visibleFirstCell: SPCHomeListCollectionCell?
    ///cellArray(方案二)
    var visibleCellsArray: Array<UICollectionViewCell> = Array<UICollectionViewCell>()
    ///数据源
    var dataSource: Array<String> = Array<String>()
    
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
        self.manyButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.singleButton.snp.centerX)
            make.top.equalTo(self.singleButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击单个播放器按钮
    @objc func clickSingleButton(_ sender: UIButton) -> () {
        let singleCellReuseCtrl = YYSingleCellReuseController()
        self.navigationController?.pushViewController(singleCellReuseCtrl, animated: true)
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
        singleButton.setTitle("单个播放器", for: .normal)
        singleButton.backgroundColor = UIColor.blue
        singleButton.titleLabel?.textColor = UIColor.white
        singleButton.addTarget(self, action: #selector(clickSingleButton(_:)), for: .touchUpInside)
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
