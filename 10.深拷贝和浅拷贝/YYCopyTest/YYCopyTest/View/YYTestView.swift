//
//  YYTestView.swift
//  YYCopyTest
//
//  Created by 杨世川 on 2022/1/12.
//

import UIKit

class YYTestView: UIView {
    //MARK:- 属性 -
    var testInt: Int = 0
    var testString: String = "0"
    //MARK:测试方法二
    var testModel: YYTestModel?{
        didSet{
            self.testInt = testModel?.testInt ?? 0
            self.testString = testModel?.testString ?? "0"
        }
    }
    
    //MARK:- Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public Methods -
    //MARK:设置模型(测试方法一)
    func setModel(model: YYTestModel) -> () {
        self.testModel = model
        self.testInt = model.testInt
        self.testString = model.testString
    }
    
    //MARK:打印模型
    func printModel() -> () {
        print("printModel========\(self.testInt)")
        print("printModel========\(self.testString)")
    }
}
