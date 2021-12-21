//
//  YYMainViewController.swift
//  YYShadowProject
//
//  Created by 杨世川 on 2021/9/23.
//

import UIKit

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
        let shadowView = UIView()
        shadowView.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        shadowView.layer.backgroundColor = UIColor.green.cgColor
        //阴影颜色
        shadowView.layer.shadowColor = UIColor.colorWithRGBHex(hex: 0x7299C1).cgColor
        //阴影透明度(默认0)
        shadowView.layer.shadowOpacity = 1.0
        //阴影圆角(默认3)
        shadowView.layer.shadowRadius = 10
        //阴影偏移量(默认(0,-3))
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //阴影路径(避免离屏渲染)
        //shadowView.layer.shadowPath = UIBezierPath.init(roundedRect: shadowView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 10, height: 10)).cgPath
        //shadowView.layer.shadowPath = UIBezierPath.init(rect: shadowView.bounds).cgPath
        view.addSubview(shadowView)
    }
    
    //布局子View
    func layoutViews() -> () {
        
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
