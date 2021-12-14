//
//  SPCHomeListCollectionCell.swift
//  SkyPiCameraiOSProject
//
//  Created by 杨世川 on 2021/12/8.
//  Copyright © 2021 skyworth. All rights reserved.
//

import UIKit

class SPCHomeListCollectionCell: UICollectionViewCell {
    //MARK:- 常量 -
    ///右侧容器宽度
    let SPCRightContainerViewWidth = 60
    ///设备名称Label高度
    let SPCDeviceNameLabelHeight = 24
    ///按钮高度
    let SPCButtonHeight = 55
    ///红色标识Flag宽高
    let SPCRedFlagWidthHeight = 7
    ///红色标识中心X偏移
    let SPCRedFlagCenterOffsetX = 12
    ///红色标识中心Y偏移
    let SPCRedFlagCenterOffsetY = -10
    
    //MARK:- 属性 -
    //属性
    var playerView: YYPlayerView?
    //MARK:父类控制器
    var superController: UIViewController = UIViewController()
    
    //MARK:- Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        self.layoutViews()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.green.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.backgroundColor = UIColor.white
        //一级View
        self.addSubview(self.mainContainerView)
        //二级View
        self.mainContainerView.addSubview(self.leftContainerView)
        self.mainContainerView.addSubview(self.rightContainerView)
        self.mainContainerView.addSubview(self.centerView)
        //三级View-left
        self.leftContainerView.addSubview(self.nameLabel)//设备名称
        //三级View-right
        self.rightContainerView.addSubview(self.warnButton)//告警按钮
        self.rightContainerView.addSubview(self.warnImageViewFlag)//告警Flag
        self.rightContainerView.addSubview(self.setButton)//设置按钮
        self.rightContainerView.addSubview(self.setImageViewFlag)//设置Flag
    }
    
    //布局子View
    func layoutViews() -> () {
        //一级View
        self.mainContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //二级View
        self.leftContainerView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.rightContainerView.snp.left)
        }
        self.rightContainerView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(SPCRightContainerViewWidth)
        }
        self.centerView.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(0)
            make.width.height.equalTo(10)
        }
        //三级View-left
        //设备名称
        self.nameLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(SPCDeviceNameLabelHeight)
        }
        //三级View-right
        self.warnButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(SPCButtonHeight)
        }
        self.warnImageViewFlag.snp.makeConstraints { make in
            make.centerX.equalTo(self.warnButton.snp.centerX).offset(SPCRedFlagCenterOffsetX)
            make.centerY.equalTo(self.warnButton.snp.centerY).offset(SPCRedFlagCenterOffsetY)
            make.width.height.equalTo(SPCRedFlagWidthHeight)
        }
        self.setButton.snp.makeConstraints { make in
            make.top.equalTo(self.warnButton.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(SPCButtonHeight)
        }
        self.setImageViewFlag.snp.makeConstraints { make in
            make.centerX.equalTo(self.setButton.snp.centerX).offset(SPCRedFlagCenterOffsetX)
            make.centerY.equalTo(self.setButton.snp.centerY).offset(SPCRedFlagCenterOffsetY)
            make.width.height.equalTo(SPCRedFlagWidthHeight)
        }
    }
    
    //MARK:- Public Methods -
    
    //MARK: - lazy  Methods -
    //MARK:- 一级View -
    //MARK:总的容器
    lazy var mainContainerView: UIView = {
        let containerView = UIView.init(frame: CGRect.zero)
        return containerView
    }()
    
    //MARK:- 二级View -
    //MARK:左侧容器
    lazy var leftContainerView: UIView = {
        let containerView = UIView.init(frame: CGRect.zero)
        return containerView
    }()
    
    //MARK:右侧容器
    lazy var rightContainerView: UIView = {
        let containerView = UIView.init(frame: CGRect.zero)
        return containerView
    }()
    
    //MARK:- 三级View-left -
    //MARK:设备名称
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.init(frame: CGRect.zero)
        nameLabel.text = "设备名称"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.backgroundColor = UIColor.colorWithRGBHex(hex: 0x020202, 1.0)
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    //MARK:- 三级View-right -
    //MARK:告警按钮
    lazy var warnButton: UIButton = {
        let warnButton = UIButton.init(frame: CGRect.zero)
        warnButton.setTitle("告警", for: .normal)
        warnButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        warnButton.setTitleColor(UIColor.colorWithRGBHex(hex: 0x555555), for: .normal)
        return warnButton
    }()
    
    //MARK:告警按钮红色标识
    lazy var warnImageViewFlag: UIImageView = {
        let warnImageViewFlag = UIImageView.init(frame: CGRect.zero)
        warnImageViewFlag.image = UIImage(named: "news_list_choose03_selected")
        return warnImageViewFlag
    }()
    
    //MARK:设置按钮
    lazy var setButton: UIButton = {
        let setButton = UIButton.init(frame: CGRect.zero)
        setButton.setTitle("设置", for: .normal)
        setButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setButton.setTitleColor(UIColor.colorWithRGBHex(hex: 0x555555), for: .normal)
        return setButton
    }()
    
    //MARK:设置按钮红色标识
    lazy var setImageViewFlag: UIImageView = {
        let setImageViewFlag = UIImageView.init(frame: CGRect.zero)
        setImageViewFlag.image = UIImage(named: "news_list_choose03_selected")
        return setImageViewFlag
    }()
    
    //MARK:添加一个中心点
    lazy var centerView: UIView = {
        let centerView = UIView.init(frame: CGRect.zero)
        centerView.backgroundColor = UIColor.red
        return centerView
    }()
    
    //MARK:当前分页Label
    lazy var currentPageLabel: UILabel = {
        let currentPageLabel = UILabel.init(frame: CGRect.zero)
        return currentPageLabel
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

