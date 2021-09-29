//
//  SPCHomeController.swift
//  testApp
//
//  Created by 杨世川 on 2021/9/22.
//

import UIKit

class SPCHomeController: UIViewController {
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
        self.view.backgroundColor = UIColor.red
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
