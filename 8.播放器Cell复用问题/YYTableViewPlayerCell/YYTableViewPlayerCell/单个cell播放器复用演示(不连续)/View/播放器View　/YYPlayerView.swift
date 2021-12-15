//
//  YYPlayerView.swift
//  YYTableViewPlayerCell
//
//  Created by 杨世川 on 2021/12/13.
//

import UIKit

class YYPlayerView: UIView {
    //MARK:- 属性 -
    //MARK:定时器
    var testTimer: Timer?
    //MARK:对应cell的name
    var cellText: String?
    
    //MARK:- Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:初始化子View
    func initViews() -> () {
        self.addSubview(self.nameLabel)
    }
    
    //MARK:布局子View
    func layoutViews() -> () {
        self.nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK:初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Private Methods -
    //MARK:定时器方法
    @objc func timeCount() -> () {
        print("定时器=================\(self.cellText ?? "")")
    }
    
    //MARK:开启定时器
    func beginTimer() -> () {
        //开启一个定时器用看看缓存
        self.testTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    }
    
    //MARK:关闭定时器
    func closeTimer() -> () {
        self.testTimer?.invalidate()
        self.testTimer = nil
    }
    
    //MARK: - lazy  Methods -
    //MARK:设备名称
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.init(frame: CGRect.zero)
        nameLabel.text = "测试复用-------"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.backgroundColor = UIColor.blue
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
}
