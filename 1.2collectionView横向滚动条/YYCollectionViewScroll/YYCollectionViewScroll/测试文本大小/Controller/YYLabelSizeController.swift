//
//  YYLabelSizeController.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

class YYLabelSizeController: UIViewController {
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
        self.view.backgroundColor = UIColor.white
        self.title = "测试文本大小"
        //初始化label
        let tempFont = UIFont.systemFont(ofSize: 16.0)
        let tempString = "extension测试"
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = tempFont
        tempLabel.text = tempString
        tempLabel.layer.borderWidth = 1.0
        tempLabel.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(tempLabel)
        //计算文本宽高
        let tempSize = tempString.getStringSizeFromBoundingRect(font: tempFont)
        //设置frame
        tempLabel.frame = CGRect(x: 100, y: 200, width: tempSize.width, height: tempSize.height)
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
